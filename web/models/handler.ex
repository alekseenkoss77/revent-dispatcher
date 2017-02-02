defmodule ReventDispatcher.Handler do
  use ReventDispatcher.Web, :model

  schema "handlers" do
    field :name, :string
    field :queue_name, :string
    many_to_many :events, ReventDispatcher.Event, join_through: ReventDispatcher.EventHandler
  end

  def changeset(handler, params \\ %{}) do
    handler
    |> cast(params, [:name, :queue_name])
    |> cast_assoc(:events)
    |> validate_required([:queue_name])
  end

  def changeset_with_events(handler, params \\ %{}) do
    handler
    |> ReventDispatcher.Repo.preload(:events)
    |> cast(params, [:name, :queue_name])
    |> cast_assoc(:events)
  end
end
