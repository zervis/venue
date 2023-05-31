defmodule VenueWeb.EventsController do
  use VenueWeb, :controller

  alias Venue.Events
  alias Venue.Events.Event
  alias Venue.Events.Comment
  alias Venue.Users

  def index(conn, _params) do
    my_events = Events.list_my_events(conn)
    events = Events.list_events(conn)
    render(conn, "index.html", my_events: my_events, events: events)
  end


  def show(conn, %{"id" => id}) do
    event = Events.get_event!(id)
    users = Users.list_users(conn)
    comment_changeset = Events.change_comment(%Comment{})
    render(conn, "show.html", event: event, users: users,
                              comment_changeset: comment_changeset)
  end

  def new(conn, _params) do
		changeset = Events.change_event(%Event{})
		render(conn, "new.html", changeset: changeset)
	end

  def add_event(conn, %{"event" => event_params}) do
    current_user = conn.assigns.current_user

    case Events.add_event(current_user, event_params) do
        {:ok, event} ->
            conn
            |> put_flash(:info, "Added event!")
            |> redirect(to: Routes.events_path(conn, :show, event.id))
        {:error, _error} ->
            conn
            |> put_flash(:error, "oopsie")
            |> redirect(to: Routes.events_path(conn, :new))
    end
  end


end
