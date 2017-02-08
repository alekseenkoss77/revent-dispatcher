defmodule ReventDispatcher.EventView do
  use ReventDispatcher.Web, :view

  def render("index.json", %{events: events}) do
    %{
      events: Enum.map(events, &event_json/1)
    }
  end

  defp event_json(event) do
    %{
      id: event.id,
      name: event.name
    }
  end
end
