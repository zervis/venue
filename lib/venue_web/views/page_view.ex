defmodule VenueWeb.PageView do
  use VenueWeb, :view
  alias Venue.Users

  def list_users(conn) do
    Users.list_users(conn)
  end

end
