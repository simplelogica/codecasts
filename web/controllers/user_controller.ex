defmodule Codecasts.UserController do
  use Codecasts.Web, :controller
  alias Codecasts.User

  def edit(conn, _) do
    user = conn.assigns.current_user
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"user" => user_params}) do
    user = conn.assigns.current_user
    user_params = user_params |> Map.delete(:email)
    
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, gettext("Profile updated successfully."))
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end
end
