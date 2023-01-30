defmodule VenueWeb.CommentController do
  use VenueWeb, :controller

  alias Venue.Events
  alias Venue.Users

  def create(conn, %{"events_id" => event_id, "comment" => comment_params}) do
    # define the post we are nested within
    event = Events.get_event!(event_id)

    # create our new comment and handle (success or failure)
    case Events.create_comment(event, comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created")
        |> redirect(to: Routes.events_path(conn, :show, event))

      # TODO: return to form and show errors
      {:error, %Ecto.Changeset{} = changeset} ->
        users = Users.list_users(conn)
        conn
        |> put_flash(:error, "Comment creation failed, please fix the errors")
        |> put_view(VenueWeb.EventView)   # as of Phoenix 1.5.1
        |> render("show.html", event: event, users: users, comment_changeset: changeset)
    end
  end

end
