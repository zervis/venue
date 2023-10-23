defmodule VenueWeb.PageController do
  use VenueWeb, :controller

  alias Venue.Feeds

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    activities = Feeds.list_activities(conn)
    invite = Feeds.list_invite(conn)

    render(conn, :home, invite: invite, activities: activities, layout: false)
  end
end
