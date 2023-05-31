defmodule Venue.MessagesTest do
  use Venue.DataCase

  alias Venue.Messages

  describe "conversations" do
    alias Venue.Messages.Conversation

    import Venue.MessagesFixtures

    @invalid_attrs %{recipient_id: nil, sender_id: nil}

    test "list_conversations/0 returns all conversations" do
      conversation = conversation_fixture()
      assert Messages.list_conversations() == [conversation]
    end

    test "get_conversation!/1 returns the conversation with given id" do
      conversation = conversation_fixture()
      assert Messages.get_conversation!(conversation.id) == conversation
    end

    test "create_conversation/1 with valid data creates a conversation" do
      valid_attrs = %{recipient_id: 42, sender_id: 42}

      assert {:ok, %Conversation{} = conversation} = Messages.create_conversation(valid_attrs)
      assert conversation.recipient_id == 42
      assert conversation.sender_id == 42
    end

    test "create_conversation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_conversation(@invalid_attrs)
    end

    test "update_conversation/2 with valid data updates the conversation" do
      conversation = conversation_fixture()
      update_attrs = %{recipient_id: 43, sender_id: 43}

      assert {:ok, %Conversation{} = conversation} = Messages.update_conversation(conversation, update_attrs)
      assert conversation.recipient_id == 43
      assert conversation.sender_id == 43
    end

    test "update_conversation/2 with invalid data returns error changeset" do
      conversation = conversation_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_conversation(conversation, @invalid_attrs)
      assert conversation == Messages.get_conversation!(conversation.id)
    end

    test "delete_conversation/1 deletes the conversation" do
      conversation = conversation_fixture()
      assert {:ok, %Conversation{}} = Messages.delete_conversation(conversation)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_conversation!(conversation.id) end
    end

    test "change_conversation/1 returns a conversation changeset" do
      conversation = conversation_fixture()
      assert %Ecto.Changeset{} = Messages.change_conversation(conversation)
    end
  end

  describe "messages" do
    alias Venue.Messages.Message

    import Venue.MessagesFixtures

    @invalid_attrs %{body: nil, read: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Messages.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Messages.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{body: "some body", read: true}

      assert {:ok, %Message{} = message} = Messages.create_message(valid_attrs)
      assert message.body == "some body"
      assert message.read == true
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{body: "some updated body", read: false}

      assert {:ok, %Message{} = message} = Messages.update_message(message, update_attrs)
      assert message.body == "some updated body"
      assert message.read == false
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_message(message, @invalid_attrs)
      assert message == Messages.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Messages.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Messages.change_message(message)
    end
  end
end
