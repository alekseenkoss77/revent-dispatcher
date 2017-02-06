defmodule ReventDispatcher.WorkerHandler do
  require Logger

  use GenServer
  use AMQP

  alias ReventDispatcher.Event

  def start_link(name \\ nil) do
    GenServer.start_link(__MODULE__, [], name: name)
  end

  def init(opts) do
    start_connection()
  end

  def push(pid, payload) do
    GenServer.cast(pid, {:push, payload})
  end

  def handle_cast({:push, payload}, chan) do
    Logger.info("[WorkerHandler] receive payload: #{payload}")
    
    case Poison.decode(payload) do
      {:ok, json} ->
        case Event.find_by_name(json["event"]) do
          event ->
            publish(chan, event, payload)
          nil -> nil
        end

      _ -> nil
    end

    {:noreply, chan}
  end

  def handle_info({:DOWN, _, :process, _pid, _reason}, _) do
    {:ok, chan} = start_connection()
    {:noreply, chan}
  end

  def handle_info({:basic_cancel_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  defp publish(chan, event, payload) do
    handlers = event.handlers()

    Enum.each(handlers, fn(handler) ->
      AMQP.Queue.declare(chan, handler.queue_name, durable: true)
      AMQP.Basic.publish(chan, "", handler.queue_name, payload, persistent: true)
    end)
  end

  defp start_connection do
    case Connection.open(Application.get_env(:revent_dispatcher, :amqp_output)) do
      {:ok, conn} -> 
        Process.monitor(conn.pid)
        {:ok, chan} = Channel.open(conn)

        Logger.info("[WorkerHandler] start new RabbitMQ connection [ok]")
        {:ok, chan}
      
      {:error, msg} ->
        Logger.error("[WorkerHandler] Error detected #{msg}. The server will be restarted.")
        :timer.sleep(10000)
        start_connection()
    end
  end
end
