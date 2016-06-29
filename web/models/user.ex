defmodule Codecasts.User do
  use Codecasts.Web, :model

  schema "users" do
    field :username, :string
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :bio, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :name, :email, :password_hash, :bio])
    |> validate_required([:username, :name, :email, :password_hash, :bio])
  end
end
