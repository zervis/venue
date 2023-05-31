defmodule Venue.Annoucments.Help do
  use Ecto.Schema
  import Ecto.Changeset
  alias Venue.Annoucments.Comment

  schema "annoucments" do
    field :description, :string
    field :title, :string
    field :geom, Geo.PostGIS.Geometry
    field :city, :string
    belongs_to :user, Venue.Users.User
    has_many :help_comments, Comment
    many_to_many :users, Venue.Users.User, join_through: "users_help"
    timestamps()
  end

  @doc false
  def changeset(help, attrs) do
    help
    |> cast(attrs, [:description, :geom, :user_id, :city])
    |> validate_required([:description, :geom, :user_id, :city])
  end
end
