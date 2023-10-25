defmodule Venue.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Venue.Events.Comment
  alias Venue.Accounts.User

  schema "events" do
    field :date, :naive_datetime
    field :title, :string
    field :geom, Geo.PostGIS.Geometry
    field :city, :string
    field :desc, :string
    belongs_to :user, User
    has_many :comments, Comment
    many_to_many :users, User, join_through: "users_events"

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :desc, :geom, :user_id, :city, :date])
    |> validate_required([:title, :desc, :geom, :user_id, :city, :date])
  end
end
