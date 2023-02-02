defmodule Venue.Repo.Migrations.AddPlacesDesc do
  use Ecto.Migration

  def change do
    alter table("places") do
      add :desc, :text
    end
  end
end
