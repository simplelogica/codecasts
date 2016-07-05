defmodule Codecasts.Repo.Migrations.AddImageToEvent do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :image, :string
    end
  end
end
