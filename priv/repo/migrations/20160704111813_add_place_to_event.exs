defmodule Codecasts.Repo.Migrations.AddPlaceToEvent do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :place, :integer, null: false
    end
  end
end
