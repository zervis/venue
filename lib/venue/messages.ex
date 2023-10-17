defmodule Venue.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias Venue.Repo

  alias Venue.Messages.Conversation
  alias Venue.Messages.Message

  @doc """
  Returns the list of conversations.

  ## Examples

      iex> list_conversations()
      [%Conversation{}, ...]

  """
  def list_conversations(conn) do
    user = conn.assigns.current_user.id
    query = from(p in Conversation, where: p.sender_id == ^user or p.recipient_id == ^user, order_by: [desc: p.updated_at], preload: [:sender, :recipient],
    select: p, preload: [messages: ^from(a in Message, order_by: [desc: a.inserted_at], distinct: a.conversation_id)])

    query
    |> Repo.all()
  end

  @doc """
  Gets a single conversation.

  Raises `Ecto.NoResultsError` if the Conversation does not exist.

  ## Examples

      iex> get_conversation!(123)
      %Conversation{}

      iex> get_conversation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_conversation!(id) do

  query = from(p in Conversation, where: p.id == ^id, select: p,
  preload: [messages: ^from(a in Message, where: a.conversation_id == ^id, order_by: [desc: a.inserted_at], preload: [:user])]
)

Repo.one!(query)

end

  @doc """
  Creates a conversation.

  ## Examples

      iex> create_conversation(%{field: value})
      {:ok, %Conversation{}}

      iex> create_conversation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_conversation(conn, attrs \\ %{}) do
    sender_id = conn.assigns.current_user.id
    %{"recipient_id" => recipient_id} = attrs
  query = from(p in Conversation, where: p.sender_id == ^sender_id and p.recipient_id == ^recipient_id or p.sender_id == ^recipient_id and p.recipient_id == ^sender_id, select: p)

  query
    |> Repo.exists?()
    |> case do
      false ->
        %Conversation{}
        |> Conversation.changeset(%{sender_id: sender_id, recipient_id: recipient_id})
        |> Repo.insert()
      true -> {:ok, Repo.one!(query)}
    end
  end


  @doc """
  Updates a conversation.

  ## Examples

      iex> update_conversation(conversation, %{field: new_value})
      {:ok, %Conversation{}}

      iex> update_conversation(conversation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_conversation(%Conversation{} = conversation, attrs) do
    conversation
    |> Conversation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a conversation.

  ## Examples

      iex> delete_conversation(conversation)
      {:ok, %Conversation{}}

      iex> delete_conversation(conversation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_conversation(%Conversation{} = conversation) do
    Repo.delete(conversation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking conversation changes.

  ## Examples

      iex> change_conversation(conversation)
      %Ecto.Changeset{data: %Conversation{}}

  """
  def change_conversation(%Conversation{} = conversation, attrs \\ %{}) do
    Conversation.changeset(conversation, attrs)
  end

  alias Venue.Messages.Message

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list_messages()
      [%Message{}, ...]

  """
  def list_messages do
    Repo.all(Message)
  end

  @doc """
  Gets a single message.

  Raises `Ecto.NoResultsError` if the Message does not exist.

  ## Examples

      iex> get_message!(123)
      %Message{}

      iex> get_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_message!(id), do: Repo.get!(Message, id)

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(conn, %Conversation{} = conversation, attrs) do
    current_user = conn.assigns.current_user.id
    %{"body" => body} = attrs
    current_date = Timex.now()
    naive = Timex.to_naive_datetime(current_date)
    now = NaiveDateTime.truncate(naive, :second)

    convo = Ecto.Changeset.change conversation, updated_at: now

    Repo.update!(convo)

    conversation
    |> Ecto.build_assoc(:messages)
    |> Message.changeset(%{body: body, user_id: current_user})
    |> Repo.insert()

  end
#|> Ecto.build_assoc(:conv)

  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a message.

  ## Examples

      iex> delete_message(message)
      {:ok, %Message{}}

      iex> delete_message(message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Ecto.Changeset{data: %Message{}}

  """
  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end
end
