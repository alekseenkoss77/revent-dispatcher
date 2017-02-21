defmodule ReventDispatcher.HandlerView do
  use ReventDispatcher.Web, :view

  def render("index.json", %{handlers: handlers}) do
    %{
      handlers: Enum.map(handlers, &handler_json/1)
    }
  end

  def render("create.json", %{data: data}) do
    handler_json(data)
  end

  def render("update.json", %{data: data}) do
    handler_json(data)
  end

  def render("destroy.json", %{data: data}) do
    handler_json(data)
  end

  defp handler_json(handler) do
    %{
      id: handler.id,
      name: handler.name,
      queue_name: handler.queue_name,
      events: Enum.map(handler.events, fn(e) -> %{name: e.name} end)
    }
  end
end
