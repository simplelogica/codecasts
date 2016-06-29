defmodule Codecasts.PageController do
  use Codecasts.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
