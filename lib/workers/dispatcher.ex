defmodule ReventDispatcher.Dispatcher do
  require Logger

  use GenServer
  use AMQP

  @queue "revent_queue"

  def start_link do
    GenServer.start_link(__MODULE__, [], [])
  end

  def init(opts) do
    start_connection()
  end

  # Confirmation sent by the broker after registering this process as a consumer
  def handle_info({:basic_consume_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  # Sent by the broker when the consumer is unexpectedly cancelled (such as after a queue deletion)
  def handle_info({:basic_cancel, %{consumer_tag: _consumer_tag}}, chan) do
    {:stop, :normal, chan}
  end

  def handle_info({:DOWN, _, :process, _pid, _reason}, _) do
    {:ok, chan} = start_connection()
    {:noreply, chan}
  end

  def handle_info({:basic_cancel_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_deliver, payload, %{delivery_tag: tag, redelivered: redelivered}}, chan) do
    spawn fn -> consume(chan, tag, redelivered, payload) end
    {:noreply, chan}
  end

  defp consume(chan, tag, _redelivered, payload) do
    Basic.ack chan, tag
    Logger.info("Received message: #{payload}")
  end

  defp start_connection do
    params = [
      username: Application.get_env(:revent_dispatcher, :amqp_consume)[:username],
      password: Application.get_env(:revent_dispatcher, :amqp_consume)[:password],
      host: Application.get_env(:revent_dispatcher, :amqp_consume)[:host],
      port: Application.get_env(:revent_dispatcher, :amqp_consume)[:port]
    ]

    case Connection.open(params) do
      {:ok, conn} -> 
        Process.monitor(conn.pid)
        {:ok, chan} = Channel.open(conn)

        Basic.qos(chan, prefetch_count: 1)
        Queue.declare(chan, @queue, durable: true)
        {:ok, _consumer_tag} = Basic.consume(chan, @queue)

        Logger.info("Dispatcher: start new RabbitMQ connection [ok]")

        {:ok, chan}
      
      {:error, _} ->
        Logger.error("Dispatcher: some error detected...Restarting...")
        :timer.sleep(10000)
        start_connection()
    end
  end
end
