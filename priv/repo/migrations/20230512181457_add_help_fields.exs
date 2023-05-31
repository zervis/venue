defmodule Venue.Repo.Migrations.AddHelpFields do
  use Ecto.Migration

  def change do
    alter table("annoucments") do
      add :geom, :geometry
      add :city, :string

    end
  end
end
