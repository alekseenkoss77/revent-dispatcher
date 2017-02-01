defmodule ReventDispatcher.EventHandler do
  use ReventDispatcher.Web, :model

  schema "events_handlers" do
    belongs_to :event, ReventDispatcher.Event
    belongs_to :handler, ReventDispatcher.Handler
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:event_id, :handler_id])
    |> validate_required([:event_id, :handler_id])
  end
end
