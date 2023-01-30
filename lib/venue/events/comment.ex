defmodule Venue.Events.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Venue.Events.Event
  alias Venue.Users.User

  @required_fields [:user_id, :event_id, :message]

  schema "comments" do
    field :message, :string
    belongs_to(:user, User)
    belongs_to(:event, Event)

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
