defmodule Venue.Repo.Migrations.AddFeed do
  use Ecto.Migration

  def change do
    create table(:feed) do
      add :data, :text
      add :type, :integer
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:feed, [:user_id])
  end
end
