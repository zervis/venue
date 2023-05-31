defmodule Venue.Repo.Migrations.CreateUniqueIndexOnConversations do
  use Ecto.Migration

  def change do
    create unique_index(:conversations, [:sender_id, :recipient_id])
  end
end
