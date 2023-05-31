defmodule Venue.Repo.Migrations.AddReferenceToConversations do
  use Ecto.Migration

  def change do
    alter table("conversations") do
      modify :sender_id, references(:users, on_delete: :nothing)
      modify :recipient_id, references(:users, on_delete: :nothing)
    end
  end
end
