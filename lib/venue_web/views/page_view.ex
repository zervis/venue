defmodule VenueWeb.PageView do
  use VenueWeb, :view
  alias Venue.Users

  alias Venue.Feeds

  def list_activities(conn) do
    Feeds.list_activities(conn)
  end

end
