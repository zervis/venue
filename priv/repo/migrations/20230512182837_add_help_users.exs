defmodule Venue.Repo.Migrations.AddHelpUsers do
  use Ecto.Migration

  def change do
      alter table("annoucments") do
        add :user_id, references("users")
      end
  end
end
