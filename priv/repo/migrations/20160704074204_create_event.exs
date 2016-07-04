defmodule Codecasts.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :description, :text
      add :video_url, :string
      add :slideshow_url, :string
      add :repository_url, :string
      add :date, :datetime
      add :creator_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:events, [:creator_id])

  end
end
