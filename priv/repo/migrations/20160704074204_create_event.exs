defmodule Codecasts.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string, null: false
      add :description, :text
      add :video_url, :string
      add :slideshow_url, :string
      add :repository_url, :string
      add :date, :datetime, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:events, [:user_id])

  end
end
