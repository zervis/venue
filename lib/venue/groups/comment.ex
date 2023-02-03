defmodule Venue.Groups.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Venue.Groups.Group
  alias Venue.Users.User

  @required_fields [:user_id, :group_id, :message]

  schema "groups_comments" do
    field :message, :string
    belongs_to(:user, User)
    belongs_to(:group, Group)

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
