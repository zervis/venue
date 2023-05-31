defmodule Venue.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :text
      add :read, :boolean, default: false, null: false
      add :conversation_id, references(:conversations, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    #create unique_index(:messages, [:conversation, :user])
    #create index(:messages, [:conversation])
    #create index(:messages, [:user])
  end
end
