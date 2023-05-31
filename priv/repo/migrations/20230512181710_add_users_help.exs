defmodule Venue.Repo.Migrations.AddUsersHelp do
  use Ecto.Migration

  def change do
    create table(:users_help) do
      add :user_id, references(:users)
      add :help_id, references(:annoucments)

      timestamps()
    end

    create unique_index(:users_help, [:help_id, :user_id])
  end
end
