defmodule Venue.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :date, :naive_datetime
      add :geom, :geometry
      
      timestamps()
    end
  end
end
