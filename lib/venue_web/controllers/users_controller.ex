defmodule VenueWeb.UsersController do
  use VenueWeb, :controller

  alias Venue.Users
  alias VenueWeb.UserAuth
  alias Venue.Events

  def index(conn, _params) do
    users = Users.list_users(conn)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
   # comment_changeset = Groups.change_comment(%Comment{})
    render(conn, "show.html", user: user
    #, comment_changeset: comment_changeset
    )
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end

end
