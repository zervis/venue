defmodule Venue.Repo.Migrations.AddUserToEvents do
  use Ecto.Migration

  def change do
    alter table("events") do
      add :user_id, references("users")
    end

    alter table("groups") do
      add :user_id, references("users")
    end

    alter table("places") do
      add :user_id, references("users")
    end
  end
end
