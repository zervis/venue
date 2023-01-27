defmodule Venue.Repo.Migrations.AddCityGroups do
  use Ecto.Migration

  def change do
    alter table("groups") do
      add :city, :string
    end
  end
end
