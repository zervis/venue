defmodule Venue.Repo.Migrations.AddPlacesPhotos do
  use Ecto.Migration

  def change do
    alter table("places") do
      add :avatar, :string
    end
  end
end
