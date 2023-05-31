defmodule VenueWeb.GroupsController do
  use VenueWeb, :controller

  alias Venue.Users
  alias Venue.Groups
  alias Venue.Groups.Group
  alias Venue.Groups.Comment

  def index(conn, _params) do
    my_groups = Groups.list_my_groups(conn)
    groups = Groups.list_groups(conn)
    render(conn, "index.html", my_groups: my_groups, groups: groups)
  end

  def new(conn, _params) do
		changeset = Groups.change_group(%Group{})
		render(conn, "new.html", changeset: changeset)
	end

  def show(conn, %{"id" => id}) do
    group = Groups.get_group!(id)
    users = Users.list_users(conn)
    comment_changeset = Groups.change_comment(%Comment{})
    render(conn, "show.html", group: group, users: users, comment_changeset: comment_changeset)
  end

  def add_group(conn, %{"group" => group_params}) do
    current_user = conn.assigns.current_user

    case Groups.add_group(current_user, group_params) do
        {:ok, group} ->
            conn
            |> put_flash(:info, "Added group!")
            |> redirect(to: Routes.groups_path(conn, :show, group.id))
        {:error, _error} ->
            conn
            |> put_flash(:error, "oopsie")
            |> redirect(to: Routes.groups_path(conn, :new))
    end
  end

end
