defmodule ReventDispatcher.Repo.Migrations.AddEventsHandlers do
  use Ecto.Migration

  def change do
    create table(:events_handlers) do
      add :event_id, :integer
      add :handler_id, :integer
    end
  end
end
