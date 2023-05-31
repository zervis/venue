defmodule VenueWeb.HelpView do
  use VenueWeb, :view
  alias Venue.Annoucments

  def list_annoucments(conn) do
    Annoucments.list_annoucments(conn)
  end
end
