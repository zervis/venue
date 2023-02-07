defmodule Venue.Repo.Migrations.CreateUsersEvents do
  use Ecto.Migration

  def change do
    create table(:users_events) do
      add :user_id, references(:users)
      add :event_id, references(:events)
    end

    create unique_index(:users_events, [:event_id, :user_id])
  end
end