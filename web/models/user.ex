defmodule Codecasts.User do
  use Codecasts.Web, :model

  schema "users" do
    field :username, :string
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :bio, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:username, :name, :email], [:bio])
    |> validate_required([:username, :name, :email])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
