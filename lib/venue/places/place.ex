defmodule Venue.Places.Place do
  use Ecto.Schema
  import Ecto.Changeset
  alias Venue.Places.Comment

  schema "places" do
    field :title, :string
    field :geom, Geo.PostGIS.Geometry
    field :city, :string
    field :desc, :string
    belongs_to :user, Venue.Users.User
    has_many(:places_comments, Comment)
    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:title, :city])
    |> validate_required([:title, :city])
  end
end
