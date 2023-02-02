defmodule Venue.Repo.Migrations.AddEventsDesc do
  use Ecto.Migration

  def change do
    alter table("events") do
      add :desc, :text
    end
  end
end
