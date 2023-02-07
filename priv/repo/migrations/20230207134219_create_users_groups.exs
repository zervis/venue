defmodule Venue.Repo.Migrations.CreateUsersGroups do
  use Ecto.Migration

  def change do
    create table(:users_groups) do
      add :user_id, references(:users)
      add :group_id, references(:groups)

      timestamps()
    end

    create unique_index(:users_groups, [:group_id, :user_id])
  end
end
