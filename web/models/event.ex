defmodule Codecasts.Event do
  use Codecasts.Web, :model

  schema "events" do
    field :title, :string
    field :description, :string
    field :video_url, :string
    field :slideshow_url, :string
    field :repository_url, :string
    field :date, Ecto.DateTime
    belongs_to :creator, Codecasts.Creator

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :video_url, :slideshow_url, :repository_url, :date])
    |> validate_required([:title, :description, :video_url, :slideshow_url, :repository_url, :date])
  end
end
