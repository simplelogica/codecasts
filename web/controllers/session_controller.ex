defmodule Codecasts.SessionController do
  use Codecasts.Web, :controller

  plug Ueberauth
  plug :put_layout, "session.html"

  alias Ueberauth.Strategy.Helpers
  alias Codecasts.User

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: session_path(conn, :login))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case User.find_or_create_from_auth(%User{}, auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: session_path(conn, :login))
    end
  end

  def login(conn, _params) do
    render conn, "login.html"
  end

  def logout(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "Successfully logged out. See you!")
    |> redirect(to: session_path(conn, :login))
  end
end
