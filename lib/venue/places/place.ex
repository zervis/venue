defmodule Venue.Places.Place do
  use Ecto.Schema
  import Ecto.Changeset

  schema "places" do
    field :title, :string
    field :geom, Geo.PostGIS.Geometry
    field :city, :string
    belongs_to :user, Venue.Users.User
    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:title, :city])
    |> validate_required([:title, :city])
  end
end
