defmodule Venue.Repo.Migrations.AddFeedData2 do
  use Ecto.Migration

  def change do
    alter table(:feed) do
      add :data2, :text
    end
  end
end
