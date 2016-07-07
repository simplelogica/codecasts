defmodule Codecasts.EventController do
  use Codecasts.Web, :controller

  plug :load_event when action in [:show, :edit, :update, :delete]

  alias Codecasts.Event

  def index(conn, %{"filter" => filters}) do
    events = Event
    |> Event.default_order()
    |> Event.filter_by_text(Map.get(filters, "q"))
    |> Event.filter_by_place(Map.get(filters, "place"))
    |> preload(:user)
    |> Repo.all()

    render(conn, "index.html", events: events)
  end

  def index(conn, _params) do
    events = Event
    |> Event.default_order()
    |> preload(:user)
    |> Repo.all()

    render(conn, "index.html", events: events)
  end

  def new(conn, _params) do
    changeset = conn.assigns.current_user
    |> build_assoc(:events)
    |> Event.changeset()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"event" => event_params}) do
    changeset = conn.assigns.current_user
    |> build_assoc(:events)
    |> Event.changeset(event_params)

    case Repo.insert(changeset) do
      {:ok, _event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: event_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => _id}) do
    event = conn.assigns.event
    render(conn, "show.html", event: event)
  end

  def edit(conn, %{"id" => _id}) do
    event = conn.assigns.event

    changeset = Event.changeset(event)
    render(conn, "edit.html", event: event, changeset: changeset)
  end

  def update(conn, %{"id" => _id, "event" => event_params}) do
    event = conn.assigns.event

    changeset = Event.changeset(event, event_params)

    case Repo.update(changeset) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: event_path(conn, :show, event))
      {:error, changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => _id}) do
    event = conn.assigns.event

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: event_path(conn, :index))
  end

  defp load_event(conn, _opts) do
    event = Repo.get_by(Event, id: conn.params["id"])
    action = conn
    |> Phoenix.Controller.action_name()

    event_loaded = current_user(conn) |> can?(action, event)

    unless (event_loaded) do
      conn
      |> put_flash(:error, gettext("Event not found or missing permissions."))
      |> redirect(to: event_path(conn, :index))
      |> halt
    else
      conn
      |> assign(:event, event)
    end
  end
end
