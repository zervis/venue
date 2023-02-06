defmodule Venue.Places.Place do
  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset
  alias Venue.Places.Comment

  schema "places" do
    field :title, :string
    field :geom, Geo.PostGIS.Geometry
    field :city, :string
    field :desc, :string
    field :avatar, Venue.Avatar.Type
    belongs_to :user, Venue.Users.User
    has_many(:places_comments, Comment)
    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:title, :desc, :geom, :user_id, :city, :avatar])
    |> cast_attachments(attrs, [:avatar])
    |> validate_required([:title, :desc, :user_id, :city, :avatar])
  end
end
