defmodule Venue.Repo.Migrations.AddUsersCityLatLon do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :city,    :string, size: 40
      add :lat, :float
      add :long, :float
    end
  end
end
