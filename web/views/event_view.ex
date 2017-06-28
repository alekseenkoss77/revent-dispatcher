defmodule ReventDispatcher.EventView do
  use ReventDispatcher.Web, :view

  def render("index.json", %{events: events}) do
    %{
      events: Enum.map(events, &event_json/1)
    }
  end

  def render("create.json", %{data: data}) do
    event_json(data)
  end

  def render("update.json", %{data: data}) do
    event_json(data)
  end

  def render("destroy.json", %{data: data}) do
    event_json(data)
  end

  def render("errors.json", %{errors: errors}) do
    %{errors: Enum.map(errors, &error_json/1)}
  end

  defp event_json(event) do
    %{
      id: event.id,
      name: event.name
    }
  end

  defp error_json({name, {message, _}}) do
    "#{name} #{message}"
  end
end
