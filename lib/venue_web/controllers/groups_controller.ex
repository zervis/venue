defmodule VenueWeb.GroupsController do
  use VenueWeb, :controller

  alias Venue.Groups
  alias Venue.Groups.Group
  
  def index(conn, _params) do
    groups = Groups.list_groups(conn)
    render(conn, "index.html", groups: groups)
  end

  def new(conn, _params) do
		changeset = Groups.change_group(%Group{})
		render(conn, "new.html", changeset: changeset)
	end

  def add_group(conn, %{"group" => group_params}) do
    current_user = conn.assigns.current_user

    case Groups.add_group(current_user, group_params) do
        {:ok, _group} ->
            conn
            |> put_flash(:info, "Added group!")
            |> redirect(to: Routes.groups_path(conn, :index))
        {:error, _error} ->
            conn
            |> put_flash(:error, "oopsie")
            |> redirect(to: Routes.groups_path(conn, :new))
    end
  end

end
