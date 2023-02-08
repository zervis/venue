defmodule VenueWeb.PageController do
  use VenueWeb, :controller

  alias Venue.Feeds
  alias Venue.Users

  def index(conn, _params) do
    activities = Feeds.list_activities(conn)
    if conn.assigns[:current_user] do
    c_user = Users.get_user!(conn.assigns.current_user.id)
    render(conn, "index.html", c_user: c_user, activities: activities)
    else
      render(conn, "index.html")
  end

  end


end
