defmodule VenueWeb.PlacesCommentController do
  use VenueWeb, :controller

  alias Venue.Places
  alias Venue.Places.Place
  alias Venue.Places.Comment
  alias Venue.Users

  def create(conn, %{"places_id" => place_id, "comment" => comment_params}) do
    # define the post we are nested within
    place = Places.get_place!(place_id)
    current_user = conn.assigns.current_user

    # create our new comment and handle (success or failure)
    case Places.create_comment(place, current_user, comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created")
        |> redirect(to: Routes.places_path(conn, :show, place))

      # TODO: return to form and show errors
      {:error, %Ecto.Changeset{} = changeset} ->
        users = Users.list_users(conn)
        conn
        |> put_flash(:error, "Comment creation failed, please fix the errors")
        |> put_view(VenueWeb.PlacesView)   # as of Phoenix 1.5.1
        |> render("show.html", place: place, users: users, comment_changeset: changeset)
    end
  end

end
