defmodule VenueWeb.HelpCommentController do
  use VenueWeb, :controller

  alias Venue.Annoucments
  alias Venue.Users

  def create(conn, %{"help_id" => help_id, "comment" => comment_params}) do
    # define the post we are nested within
    help = Annoucments.get_help!(help_id)
    current_user = conn.assigns.current_user

    # create our new comment and handle (success or failure)
    case Annoucments.create_comment(help, current_user, comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created")
        |> redirect(to: Routes.help_path(conn, :show, help))

      # TODO: return to form and show errors
      {:error, %Ecto.Changeset{} = changeset} ->
        users = Users.list_users(conn)
        conn
        |> put_flash(:error, "Comment creation failed, please fix the errors")
        |> put_view(VenueWeb.HelpView)   # as of Phoenix 1.5.1
        |> render("show.html", help: help, users: users, comment_changeset: changeset)
    end
  end

end
