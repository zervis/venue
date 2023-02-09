defmodule Venue.Repo.Migrations.AddSkipUsers do
  use Ecto.Migration

  def change do
    create table(:skipped) do
      add :user_id, references(:users)
      add :relation_id, references(:users)
      timestamps()
    end

    create index(:skipped, [:user_id])
    create index(:skipped, [:relation_id])

    create unique_index(
      :skipped,
      [:user_id, :relation_id],
      name: :skipped_user_id_relation_id_index
    )

    create unique_index(
      :skipped,
      [:relation_id, :user_id],
      name: :skipped_relation_id_user_id_index
    )
  end
end
