defmodule Venue.Repo.Migrations.AddUsersDistance do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :distance, :integer, default: 25
    end
  end
end
