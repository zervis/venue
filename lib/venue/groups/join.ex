defmodule Venue.Groups.Join do
    use Ecto.Schema
  
    schema "users_groups" do
      field :user_id, :id
      field :group_id, :id
      timestamps()
    end
  
  
  @attrs [:user_id, :group_id]
  
  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, @attrs)
    |> Ecto.Changeset.unique_constraint(
      [:user_id, :group_id],
      name: :users_groups_group_id_user_id_index
    )
  end

  def quit_changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, @attrs)
  end
  end