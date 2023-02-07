defmodule VenueWeb.JoinEventController do
  use VenueWeb, :controller

  alias Venue.Events
  alias Venue.Users

  def create(conn, %{"events_id" => event_id}) do
    # define the post we are nested within
    event = Events.get_event!(event_id)
    current_user = conn.assigns.current_user

    # create our new comment and handle (success or failure)
    case Events.join_event(event.id, current_user) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Joined")
        |> redirect(to: Routes.events_path(conn, :show, event))

      # TODO: return to form and show errors
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Already joined")
        |> put_view(VenueWeb.EventsView)   # as of Phoenix 1.5.1
        |> render("show.html", event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"events_id" => event_id}) do
    # define the post we are nested within
    event = Events.get_event!(event_id)
    current_user = conn.assigns.current_user
    events = Events.list_events(conn)
    # create our new comment and handle (success or failure)
    case Events.quit_event(event.id, current_user) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Event leaved")
        |> put_view(VenueWeb.PageView)   # as of Phoenix 1.5.1
        |> render("index.html", events: events)

      # TODO: return to form and show errors
      _ ->
        conn
        |> put_flash(:info, "Quited")
        |> put_view(VenueWeb.EventsView)   # as of Phoenix 1.5.1
        |> render("index.html", events: events)
    end
  end

end
