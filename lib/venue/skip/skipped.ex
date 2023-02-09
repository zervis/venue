defmodule Venue.Skip.Skipped do
  use Ecto.Schema

  schema "skipped" do
    field :user_id, :id
    field :relation_id, :id
    timestamps()
  end


@attrs [:user_id, :relation_id]

def changeset(struct, params \\ %{}) do
  struct
  |> Ecto.Changeset.cast(params, @attrs)
  |> Ecto.Changeset.unique_constraint(
    [:user_id, :relation_id],
    name: :skipped_user_id_relation_id_index
  )
  |> Ecto.Changeset.unique_constraint(
    [:relation_id, :user_id],
    name: :skipped_relation_id_user_id_index
  )
end
end
