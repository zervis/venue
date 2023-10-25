defmodule Venue.Events.Join do
  use Ecto.Schema

  schema "users_events" do
    field :user_id, :id
    field :event_id, :id
    timestamps()
  end

  @attrs [:user_id, :event_id]

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, @attrs)
    |> Ecto.Changeset.unique_constraint(
      [:user_id, :event_id],
      name: :users_events_event_id_user_id_index
    )
  end

  def quit_changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, @attrs)
  end
end

