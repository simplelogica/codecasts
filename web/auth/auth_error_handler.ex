defmodule Codecasts.AuthErrorHandler do
  use Codecasts.Web, :controller

  # The unauthenticated function is called because this controller has been
  # specified as the handler.
  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, gettext("Authentication required"))
    |> redirect(to: session_path(conn, :login))
  end
end
