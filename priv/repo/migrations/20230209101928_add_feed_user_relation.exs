defmodule Venue.Repo.Migrations.AddFeedUserRelation do
  use Ecto.Migration

  def change do
    alter table(:feed) do
      add :relation_id, references(:users, on_delete: :delete_all)
    end
  end
end
