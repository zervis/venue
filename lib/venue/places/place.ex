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
    field :avatar, Venue.Photo.Type
    belongs_to :user, Venue.Users.User
    has_many(:places_comments, Comment)
    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:title, :geom, :user_id, :city])
    |> validate_required([:title, :user_id, :city])
  end

  def photo_changeset(place, attrs) do
    place
    |> cast_attachments(attrs, [:avatar])
    |> validate_required([:avatar])
  end
end
