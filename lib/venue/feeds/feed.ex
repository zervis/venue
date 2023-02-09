defmodule Venue.Feeds.Feed do
  use Ecto.Schema
  import Ecto.Changeset
  alias Venue.Users.User

  @required_fields [:user_id, :type, :data]

  schema "feed" do
    belongs_to(:user, User)
    belongs_to(:relation, User)
    field :type, :integer
    field :data, :string
    field :data2, :string
    field :message, :string
    timestamps()
  end

  @doc false
  def changeset(attrs) do
    attrs
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

end
