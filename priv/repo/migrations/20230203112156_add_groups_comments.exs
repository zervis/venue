defmodule Venue.Repo.Migrations.AddGroupsComments do
  use Ecto.Migration

  def change do
    create table(:groups_comments) do
      add :message, :text
      add :group_id, references(:groups, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:groups_comments, [:group_id])
    create index(:groups_comments, [:user_id])
  end
end
