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

  @doc """
  Scope to filter events by title or description.
  Return query without modification if no string or empty string is received.
  """
  def filter_by_text(query, str) when (is_binary(str)) do
    query_string = "%#{str}%"

    if String.length(str) > 0 do
      from e in query,
        where: (like(e.title, ^query_string)) or (like(e.description, ^query_string))
    else
      query
    end
  end
  def filter_by_text(query, _), do: query

  @doc """
  Scope to filter events by place.
  Return query without modification if no atom is received.
  """
  def filter_by_place(query, place) when (is_atom(place)) do
    from e in query,
      where: e.place == ^place
  end
  def filter_by_place(query, _), do: query

  @doc """
  Scope to get `number` events coming soon.
  """
  def next_events(number \\ 3) do
    actual_date = Ecto.DateTime.from_erl(:calendar.universal_time())

    from e in __MODULE__,
      where: e.date >= ^actual_date,
      limit: ^number,
      order_by: [asc: e.date],
      select: e
  end

  @doc """
  Scope to get `number` events past.
  """
  def last_events(number \\ 3) do
    actual_date = Ecto.DateTime.from_erl(:calendar.universal_time())

    from e in __MODULE__,
      where: e.date <= ^actual_date,
      limit: ^number,
      order_by: [desc: e.date],
      select: e
  end

  # Custom validation to perform format validation only if the field has value.
  #
  defp validate_format_optional(changeset, field, format, opts \\ []) do
    if (changeset.changes[field] && String.length(changeset.changes[field]) > 0) do
      changeset
      |> validate_format(field, format, opts)
    else
      changeset
    end
  end
end
