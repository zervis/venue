defmodule Venue.Repo.Migrations.AddCityPlaces do
  use Ecto.Migration

  def change do
    alter table("places") do
      add :city, :string
    end
  end
end
