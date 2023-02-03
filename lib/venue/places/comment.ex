defmodule Venue.Places.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Venue.Places.Place
  alias Venue.Users.User

  @required_fields [:user_id, :place_id, :message]

  schema "places_comments" do
    field :message, :string
    belongs_to(:user, User)
    belongs_to(:place, Place)

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
