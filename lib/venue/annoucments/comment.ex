defmodule Venue.Annoucments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Venue.Annoucments.Help
  alias Venue.Users.User

  @required_fields [:user_id, :help_id, :message]

  schema "help_comments" do
    field :message, :string
    belongs_to(:user, User)
    belongs_to(:help, Help)

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
