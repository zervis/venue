defmodule VenueWeb.EventsView do
  use VenueWeb, :view
  alias Venue.Events

  def list_events(conn) do
    Events.list_events(conn)
  end

end
