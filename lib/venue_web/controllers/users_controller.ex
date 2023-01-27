defmodule VenueWeb.UsersController do
  use VenueWeb, :controller

  alias Venue.Users
  alias VenueWeb.UserAuth

  def index(conn, _params) do
    users = Users.list_users(conn)
    render(conn, "index.html", users: users)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end

end
