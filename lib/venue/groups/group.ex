defmodule Venue.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias Venue.Groups.Comment
  
  schema "groups" do
    field :title, :string
    field :geom, Geo.PostGIS.Geometry
    field :city, :string
    field :desc, :string
    belongs_to :user, Venue.Users.User
    has_many(:groups_comments, Comment)
    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:title, :city])
    |> validate_required([:title,  :city])
  end
end
