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
    has_many :groups_comments, Comment
    many_to_many :users, Venue.Users.User, join_through: "users_groups"
    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:title, :desc, :geom, :user_id, :city])
    |> validate_required([:title, :desc, :geom, :user_id, :city])
  end
end
