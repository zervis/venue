defmodule Venue.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :title, :string
    field :geom, Geo.PostGIS.Geometry
    field :city, :string
    field :desc, :string
    belongs_to :user, Venue.Users.User
    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:title, :city])
    |> validate_required([:title,  :city])
  end
end
