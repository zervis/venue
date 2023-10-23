defmodule VenueWeb.PageController do
  use VenueWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, invite: [], activities: [], layout: false)
  end
end
