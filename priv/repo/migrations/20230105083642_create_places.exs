defmodule Venue.Repo.Migrations.CreatePlaces do
  use Ecto.Migration

  def change do
    create table(:places) do
      add :title, :string
      add :geom, :geometry

      timestamps()
    end
  end
end
