defmodule ReventDispatcher.Repo.Migrations.AddHandlers do
  use Ecto.Migration

  def change do
    create table(:handlers) do
      add :name, :string
      add :queue_name, :string
    end

    create index(:handlers, [:queue_name])
  end
end
