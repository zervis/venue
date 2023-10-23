defmodule VenueWeb.ConversationHTML do
  use VenueWeb, :html

  embed_templates "conversation_html/*"

  @doc """
  Renders a conversation form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def conversation_form(assigns)
end
