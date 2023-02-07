defmodule VenueWeb.JoinGroupController do
  use VenueWeb, :controller

  alias Venue.Groups
  alias Venue.Users

  def create(conn, %{"groups_id" => group_id}) do
    # define the post we are nested within
    group = Groups.get_group!(group_id)
    current_user = conn.assigns.current_user

    # create our new comment and handle (success or failure)
    case Groups.join_group(group.id, current_user) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Joined")
        |> redirect(to: Routes.groups_path(conn, :show, group))

      # TODO: return to form and show errors
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Already joined")
        |> put_view(VenueWeb.GroupsView)   # as of Phoenix 1.5.1
        |> render("show.html", group: group, changeset: changeset)
    end
  end

  def delete(conn, %{"groups_id" => group_id}) do
    # define the post we are nested within
    group = Groups.get_group!(group_id)
    current_user = conn.assigns.current_user
    groups = Groups.list_groups(conn)
    # create our new comment and handle (success or failure)
    case Groups.quit_group(group.id, current_user) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "group leaved")
        |> put_view(VenueWeb.PageView)   # as of Phoenix 1.5.1
        |> render("index.html", groups: groups)

      # TODO: return to form and show errors
      _ ->
        conn
        |> put_flash(:info, "Quited")
        |> put_view(VenueWeb.GroupsView)   # as of Phoenix 1.5.1
        |> render("index.html", groups: groups)
    end
  end

end
