defmodule Venue.Repo.Migrations.AddCityEvents do
  use Ecto.Migration

  def change do
    alter table("events") do
      add :city, :string
    end
  end
end
