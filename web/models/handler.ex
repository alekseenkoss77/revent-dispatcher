defmodule ReventDispatcher.Handler do
  use ReventDispatcher.Web, :model

  alias ReventDispatcher.Event
  alias ReventDispatcher.Repo

  schema "handlers" do
    field :name, :string
    field :queue_name, :string
    many_to_many :events, ReventDispatcher.Event, join_through: ReventDispatcher.EventHandler, on_replace: :delete
  end

  def changeset(handler, params \\ %{}) do
    handler
    |> cast(params, [:name, :queue_name])
    |> cast_assoc(:events)
    |> validate_required([:queue_name])
  end

  def changeset_with_events(handler, params \\ %{}) do
    events = Repo.all(from e in Event, where: e.id in ^params["events"])

    handler
    |> Repo.preload(:events)
    |> cast(params, [:name, :queue_name])
    |> validate_required([:queue_name])
    |> put_assoc(:events, events)
  end

  def get_queues do
    Repo.all(from h in "handlers", select: h.queue_name)
  end
end
