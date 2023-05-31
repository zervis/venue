defmodule Venue.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Venue.Messages` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        message: "some message",
        recipient_id: 42,
        sender_id: 42
      })
      |> Venue.Messages.create_message()

    message
  end

  @doc """
  Generate a conversation.
  """
  def conversation_fixture(attrs \\ %{}) do
    {:ok, conversation} =
      attrs
      |> Enum.into(%{
        recipient_id: 42,
        sender_id: 42
      })
      |> Venue.Messages.create_conversation()

    conversation
  end

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        body: "some body",
        read: true
      })
      |> Venue.Messages.create_message()

    message
  end
end
