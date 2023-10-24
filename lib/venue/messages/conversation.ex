defmodule Venue.Messages.Conversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Venue.Messages.Message
  alias Venue.Accounts.User

  schema "conversations" do
    belongs_to :recipient, User
    belongs_to :sender, User
    # field :recipient_id, :integer
    # field :sender_id, :integer
    has_many :messages, Message

    # validates_uniqueness_of :sender_id, :scope => :recipient_id
    # scope :between, -> (sender_id,recipient_id) do
    # where(“(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)”, sender_id,recipient_id, recipient_id, sender_id)
    # end

    timestamps()
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:sender_id, :recipient_id])
    |> validate_required([:recipient_id])
  end
end
