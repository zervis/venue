defmodule Venue.Repo.Migrations.AddPlacesComments do
  use Ecto.Migration

    def change do
      create table(:places_comments) do
        add :message, :text
        add :place_id, references(:places, on_delete: :delete_all), null: false
        add :user_id, references(:users, on_delete: :delete_all), null: false

        timestamps()
      end

      create index(:places_comments, [:place_id])
      create index(:places_comments, [:user_id])

  end
end
