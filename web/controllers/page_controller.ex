defmodule Codecasts.PageController do
  use Codecasts.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Codecasts.AuthHandler

  def index(conn, _params) do
    render conn, "index.html"
  end
end
