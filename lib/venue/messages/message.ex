defmodule Venue.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Venue.Users.User
  alias Venue.Messages.Conversation

  schema "messages" do
    field :body, :string
    field :read, :boolean, default: false
    #field :conversation, :id
    #field :user, :id
    belongs_to :conversation, Conversation
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :read, :user_id, :conversation_id])
    |> validate_required([:body, :read])
  end
end
