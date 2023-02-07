defmodule Venue.Repo.Migrations.AlterUsersEvents do
  use Ecto.Migration

  def change do
    alter table(:users_events) do
      timestamps()
    end
  end
end
