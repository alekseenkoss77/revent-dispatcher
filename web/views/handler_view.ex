defmodule ReventDispatcher.HandlerView do
  use ReventDispatcher.Web, :view

  def render("index.json", %{handlers: handlers}) do
    %{
      handlers: Enum.map(handlers, &handler_json/1)
    }
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
