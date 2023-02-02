defmodule Venue.Repo.Migrations.AddGroupDesc do
  use Ecto.Migration

  def change do
    alter table("groups") do
      add :desc, :text
    end
  end
end
