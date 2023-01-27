defmodule VenueWeb.EventsController do
  use VenueWeb, :controller

  alias Venue.Events
  alias Venue.Events.Event

  def index(conn, _params) do
    events = Events.list_events(conn)
    render(conn, "index.html", events: events)
  end

  def new(conn, _params) do
		changeset = Events.change_event(%Event{})
		render(conn, "new.html", changeset: changeset)
	end

  def add_event(conn, %{"event" => event_params}) do
    current_user = conn.assigns.current_user

    case Events.add_event(current_user, event_params) do
        {:ok, _event} ->
            conn
            |> put_flash(:info, "Added event!")
            |> redirect(to: Routes.events_path(conn, :index))
        {:error, _error} ->
            conn
            |> put_flash(:error, "oopsie")
            |> redirect(to: Routes.events_path(conn, :new))
    end
  end


end
