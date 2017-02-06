defmodule ReventDispatcher.Event do
  use ReventDispatcher.Web, :model

  alias ReventDispatcher.Repo
  alias ReventDispatcher.Handler
  alias ReventDispatcher.EventHandler

  schema "events" do
    field :name, :string
    many_to_many :handlers, Handler, join_through: EventHandler
  end

  def changeset(event, params \\ %{}) do
    event
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  def find_by_name(event_name) do 
    Repo.get_by(__MODULE__, name: event_name)
    |> Repo.preload(:handlers)
  end
end
