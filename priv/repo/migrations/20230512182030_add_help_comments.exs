defmodule Venue.Repo.Migrations.AddHelpComments do
  use Ecto.Migration

  def change do
    create table(:help_comments) do
      add :message, :text
      add :help_id, references(:annoucments, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:help_comments, [:help_id])
    create index(:help_comments, [:user_id])
  end
end
