defmodule VenueWeb.EventHTML do
  use VenueWeb, :html
  alias Venue.Accounts.User

  embed_templates "event_html/*"

  @doc """
  Renders a event form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :user, User, required: true
  attr :action, :string, required: true

  def event_form(assigns)
end
