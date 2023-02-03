defmodule Venue.Repo.Migrations.AddUsersNameAndSex do
  use Ecto.Migration

    def change do
      alter table("users") do
        add :name, :string
        add :sex, :string
      end
  end
end
