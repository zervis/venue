defmodule Venue.Repo.Migrations.AddUsersBirth do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :birth, :date
    end
  end
end
