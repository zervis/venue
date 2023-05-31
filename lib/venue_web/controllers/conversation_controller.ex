defmodule VenueWeb.ConversationController do
  use VenueWeb, :controller

  alias Venue.Messages
  alias Venue.Messages.Conversation
  alias Venue.Messages.Message
  alias Venue.Users

  def index(conn, _params) do
    conversations = Messages.list_conversations(conn)
    render(conn, "index.html", conversations: conversations)
  end

  def new(conn, _params) do
    changeset = Messages.change_conversation(%Conversation{})
    friends = Users.list_friends(conn)
    render(conn, "new.html", changeset: changeset, friends: friends)
  end

  def create(conn, %{"conversation" => conversation_params}) do
  #  if (conversation_params[:sender_id], conversation_params[:recipient_id]) ||
    #.present?
    # @conversation = Conversation.between(params[:sender_id],
   #   params[:recipient_id]).first
  #else
    case Messages.create_conversation(conn, conversation_params) do
      {:ok, conversation} ->
        case Messages.create_message(conn, conversation, conversation_params) do
          {:ok, message} ->
            conn
            |> put_flash(:info, "Conversation created successfully.")
            |> redirect(to: Routes.conversation_path(conn, :show, conversation))

          {:error, %Ecto.Changeset{} = changeset} ->
              render(conn, "new.html", changeset: changeset)
        end
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
 # end
  end



  def show(conn, %{"id" => id}) do
    conversation = Messages.get_conversation!(id)
    changeset = Messages.change_message(%Message{})
    render(conn, "show.html", conversation: conversation, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    conversation = Messages.get_conversation!(id)
    changeset = Messages.change_conversation(conversation)
    render(conn, "edit.html", conversation: conversation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "conversation" => conversation_params}) do
    conversation = Messages.get_conversation!(id)

    case Messages.update_conversation(conversation, conversation_params) do
      {:ok, conversation} ->
        conn
        |> put_flash(:info, "Conversation updated successfully.")
        |> redirect(to: Routes.conversation_path(conn, :show, conversation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", conversation: conversation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    conversation = Messages.get_conversation!(id)
    {:ok, _conversation} = Messages.delete_conversation(conversation)

    conn
    |> put_flash(:info, "Conversation deleted successfully.")
    |> redirect(to: Routes.conversation_path(conn, :index))
  end
end
