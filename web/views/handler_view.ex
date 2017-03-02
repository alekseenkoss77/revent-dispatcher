defmodule ReventDispatcher.HandlerView do
  use ReventDispatcher.Web, :view

  def render("index.json", %{handlers: handlers, events: events}) do
    %{
      handlers: Enum.map(handlers, &handler_json/1),
      events: render_events_list(events)
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
      events: render_events_list(handler.events)
    }
  end

  defp render_events_list(events) do
    Enum.map(events, fn(e) -> %{name: e.name, id: e.id} end)
  end
end
