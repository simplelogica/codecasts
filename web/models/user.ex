defmodule Codecasts.User do
  use Codecasts.Web, :model

  alias Codecasts.Repo
  alias Ueberauth.Auth

  schema "users" do
    field :username, :string
    field :name, :string
    field :email, :string
    field :bio, :string
    field :admin, :boolean

    has_many :events, Codecasts.Event

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
    user = from(from t in Codecasts.User, where: t.email == ^auth.info.email, select: t)
        |> Repo.one

    if check_email_domain(auth.info.email) do
      user = case user do
        nil ->
          name = if (String.length(auth.info.name) == 0) do
            get_username_from_email(auth.info.email)
          else
            auth.info.name
          end

          model
          |> changeset(%{
              name: name,
              username: get_username_from_email(auth.info.email),
              email: auth.info.email
              })
          |> Repo.insert!
        _ ->
          user
      end

      {:ok, user}
    else
      {:error, nil}
    end
  end

  defp check_email_domain(email) do
    domain_whitelist = Application.get_env(:codecasts, :domain_whitelist)

    valid = case length(domain_whitelist) do
      0 ->
        true
      _ ->
        domain_whitelist
        |> Enum.map( fn(x) -> email |> String.split("@") |> Enum.at(1) == x end )
        |> Enum.any?(fn(x) -> x == true end)
    end

    valid
  end


  defp get_username_from_email(email) do
    email
    |> String.split("@")
    |> Enum.at(0)
  end
end
