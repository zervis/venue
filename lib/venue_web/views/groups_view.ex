defmodule VenueWeb.GroupsView do
  use VenueWeb, :view
  alias Venue.Groups

  def list_groups(conn) do
    Groups.list_groups(conn)
  end

end
