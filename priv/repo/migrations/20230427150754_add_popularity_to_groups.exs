defmodule Venue.Repo.Migrations.AddPopularityToGroups do
  use Ecto.Migration

  def change do
    alter table(:groups) do
      add :popularity, :integer, default: 0
    end
  end
end
