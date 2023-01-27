defmodule Venue.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :date, :naive_datetime
    field :title, :string
    field :geom, Geo.PostGIS.Geometry
    field :city, :string


    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :city, :date])
    |> validate_required([:title, :city, :date])
  end
end
