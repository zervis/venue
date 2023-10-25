defmodule VenueWeb.EventController do
  use VenueWeb, :controller

  alias Venue.Accounts
  alias Venue.Events
  alias Venue.Events.{Comment, Event}

  def index(conn, _params) do
    my_events = Events.list_my_events(conn)
    events = Events.list_events(conn)

    render(conn, :index, my_events: my_events, events: events)
  end

  def new(conn, _params) do
    changeset = Events.change_event(%Event{})
    render(conn, :new, changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    event = Events.get_event!(id)
    users = Accounts.list_users(conn)
    comment_changeset = %Comment{} |> Events.change_comment()

    render(conn, :show, event: event, users: users, comment_changeset: comment_changeset)
  end

  def create(conn, %{"event" => event_params}) do
    current_user = conn.assigns.current_user

    case Events.add_event(current_user, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Added event!")
        |> redirect(to: ~p"/events/show?#{event.id}")

      {:error, _error} ->
        conn
        |> put_flash(:error, "oopsie")
        |> redirect(to: ~p"/events/new")
    end
  end
end
