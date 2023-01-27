defmodule VenueWeb.PageController do
  use VenueWeb, :controller

  alias Venue.Users

  def index(conn, _params) do
    users = Users.list_users(conn)
    render(conn, "index.html", users: users)
  end

end
