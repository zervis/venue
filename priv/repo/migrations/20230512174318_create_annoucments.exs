defmodule Venue.Repo.Migrations.CreateAnnoucments do
  use Ecto.Migration

  def change do
    create table(:annoucments) do
      add :title, :string
      add :description, :string

      timestamps()
    end
  end
end
