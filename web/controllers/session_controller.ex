defmodule Codecasts.SessionController do
  use Codecasts.Web, :controller

  plug :put_layout, "session.html"

  def new(conn, _params) do
    render conn, "login.html"
  end
end
