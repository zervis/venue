defmodule VenueWeb.UsersController do
  use VenueWeb, :controller

  alias Venue.Users
  alias VenueWeb.UserAuth
  alias Venue.Relationships.Relationship

  def index(conn, _params) do
    ## friends = Users.list_friends(conn)
    users = Users.list_users(conn)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    relation_changeset = Relationship.changeset(%Relationship{}, %{})
    render(conn, "show.html", user: user, changeset: relation_changeset)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end

end
