defmodule ReventDispatcher.Repo.Migrations.AddEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
    end

    create index(:events, [:name])
  end
end
