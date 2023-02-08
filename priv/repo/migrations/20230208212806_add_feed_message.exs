defmodule Venue.Repo.Migrations.AddFeedMessage do
  use Ecto.Migration

  def change do
    alter table(:feed) do
      add :message, :text
    end
  end
end
