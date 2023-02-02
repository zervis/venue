defmodule Venue.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Venue.Events.Comment

  schema "events" do
    field :date, :naive_datetime
    field :title, :string
    field :geom, Geo.PostGIS.Geometry
    field :city, :string
    field :desc, :string
    belongs_to :user, Venue.Users.User
    has_many(:comments, Comment)

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :city, :date])
    |> validate_required([:title, :city, :date])
  end
end
