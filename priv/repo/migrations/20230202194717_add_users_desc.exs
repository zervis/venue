defmodule Venue.Repo.Migrations.AddUsersDesc do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :desc, :text
    end
  end
end
