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
  Builds a changeset based on the `model` and `params`.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:username, :name, :email], [:bio])
    |> validate_required([:username, :name, :email])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end

  @doc """
  Registration changeset that uses the normal changeset and also requires a password to generate
  a valid password hash.
  """
  def registration_changeset(model, params \\ %{}) do
    model
    |> changeset(params)
    |> cast(params, [:password], [])
    |> validate_length(:password, min: 6, max: 100)
    |> generate_password_hash()
  end

  # Auxiliar function to generate the password hash and put it on the changeset
  #
  defp generate_password_hash(changeset) do
    case changeset do
      # If it is a valid changeset and contains a password, regenerate the hash
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

      # If not, just return the changeset without changes
      _ ->
        changeset
    end
  end
end
