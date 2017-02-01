defmodule ReventDispatcher.Event do
  use ReventDispatcher.Web, :model

  schema "events" do
    field :name, :string
    many_to_many :handlers, ReventDispatcher.Handler, join_through: ReventDispatcher.EventHandler
  end

  def changeset(event, params \\ %{}) do
    event
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
