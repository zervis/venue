defmodule VenueWeb.GroupsCommentController do
  use VenueWeb, :controller

  alias Venue.Groups
  alias Venue.Users

  def create(conn, %{"groups_id" => group_id, "comment" => comment_params}) do
    # define the post we are nested within
    group = Groups.get_group!(group_id)
    current_user = conn.assigns.current_user

    # create our new comment and handle (success or failure)
    case Groups.create_comment(group, current_user, comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created")
        |> redirect(to: Routes.groups_path(conn, :show, group))

      # TODO: return to form and show errors
      {:error, %Ecto.Changeset{} = changeset} ->
        users = Users.list_users(conn)
        conn
        |> put_flash(:error, "Comment creation failed, please fix the errors")
        |> put_view(VenueWeb.GroupsView)   # as of Phoenix 1.5.1
        |> render("show.html", group: group, users: users, comment_changeset: changeset)
    end
  end

end
