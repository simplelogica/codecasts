defmodule Codecasts.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :name, :string, null: false
      add :email, :string, null: false
      add :bio, :string

      timestamps()
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:name])

  end
end
