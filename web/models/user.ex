defmodule Codecasts.User do
  use Codecasts.Web, :model

  alias Codecasts.Repo
  alias Ueberauth.Auth

  schema "users" do
    field :username, :string
    field :name, :string
    field :email, :string
    field :bio, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `model` and `params`.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:username, :name, :email, :bio])
    |> validate_required([:username, :name, :email])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end

  def find_or_create_from_auth(model, %Auth{} = auth) do
    user = from(from t in __MODULE__, where: t.email == ^auth.info.email, select: t)
        |> Repo.one

    if (user == nil) do
      user = model
        |> changeset(%{
            name: auth.info.name,
            username: get_username_from_email(auth.info.email),
            email: auth.info.email
            })
        |> Repo.insert!
    end

    {:ok, user}
  end

  defp get_username_from_email(email) do
    email
    |> String.split("@")
    |> Enum.at(0)
  end
end
