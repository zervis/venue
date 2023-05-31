defmodule VenueWeb.MessageController do
  use VenueWeb, :controller

  alias Venue.Messages
  alias Venue.Messages.Message

  def index(conn, _params) do
    messages = Messages.list_messages()
    changeset = Messages.change_message(%Message{})
    render(conn, "index.html", messages: messages, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Messages.change_message(%Message{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"conversation_id" => conversation_id, "message" => message_params}) do
    conversation = Messages.get_conversation!(conversation_id)
    case Messages.create_message(conn, conversation, message_params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message created successfully.")
        |> redirect(to: Routes.conversation_path(conn, :show, conversation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Messages.get_message!(id)
    render(conn, "show.html", message: message)
  end

  def edit(conn, %{"id" => id}) do
    message = Messages.get_message!(id)
    changeset = Messages.change_message(message)
    render(conn, "edit.html", message: message, changeset: changeset)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Messages.get_message!(id)

    case Messages.update_message(message, message_params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message updated successfully.")
        |> redirect(to: Routes.message_path(conn, :show, message))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", message: message, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Messages.get_message!(id)
    {:ok, _message} = Messages.delete_message(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: Routes.message_path(conn, :index))
  end
end
