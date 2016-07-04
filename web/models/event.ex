defmodule Codecasts.Event do
  use Codecasts.Web, :model

  schema "events" do
    field :title, :string
    field :description, :string
    field :video_url, :string
    field :slideshow_url, :string
    field :repository_url, :string
    field :date, Ecto.DateTime
    field :place, EventPlaceEnum

    belongs_to :user, Codecasts.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :video_url, :slideshow_url, :repository_url, :date, :place, :user_id])
    |> validate_required([:title, :description, :date, :user_id])
    |> validate_format_optional(:video_url, ~r/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/)
    |> validate_format_optional(:slideshow_url, ~r/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/)
    |> validate_format_optional(:repository_url, ~r/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/)
  end

  defp validate_format_optional(changeset, field, format, opts \\ []) do
    if (changeset.changes[field] && String.length(changeset.changes[field]) > 0) do
      changeset
      |> validate_format(field, format, opts)
    else
      changeset
    end
  end
end
