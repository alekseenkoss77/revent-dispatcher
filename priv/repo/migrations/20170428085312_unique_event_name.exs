defmodule ReventDispatcher.Repo.Migrations.UniqueEventName do
  use Ecto.Migration

  def change do
    drop index(:events, [:name])
    create unique_index(:events, [:name])
  end
end
