defmodule VenueWeb.PlacesView do
  use VenueWeb, :view
  alias Venue.Places

  def list_places(conn) do
    Places.list_places(conn)
  end

end
