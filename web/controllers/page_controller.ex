defmodule Codecasts.PageController do
  use Codecasts.Web, :controller

  alias Codecasts.Event

  plug Guardian.Plug.EnsureAuthenticated, handler: Codecasts.AuthHandler

  def index(conn, _params) do
    next_events = Event.next_events(3)
    |> preload(:user)
    |> Repo.all

    last_events = Event.last_events(6)
    |> preload(:user)
    |> Repo.all

    render conn, "index.html",
      next_events: next_events,
      last_events: last_events
  end
end
