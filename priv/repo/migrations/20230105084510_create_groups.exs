defmodule Venue.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :title, :string
      add :geom, :geometry
      
      timestamps()
    end
  end
end
