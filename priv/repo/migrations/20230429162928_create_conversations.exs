defmodule Venue.Repo.Migrations.CreateConversations do
  use Ecto.Migration

  def change do
    create table(:conversations) do
      add :sender_id, :integer
      add :recipient_id, :integer

      timestamps()
    end
  end
end
