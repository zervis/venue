defmodule VenueWeb.ConversationControllerTest do
  use VenueWeb.ConnCase

  import Venue.MessagesFixtures

  @create_attrs %{recipient_id: 42, sender_id: 42}
  @update_attrs %{recipient_id: 43, sender_id: 43}
  @invalid_attrs %{recipient_id: nil, sender_id: nil}

  describe "index" do
    test "lists all conversations", %{conn: conn} do
      conn = get(conn, Routes.conversation_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Conversations"
    end
  end

  describe "new conversation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.conversation_path(conn, :new))
      assert html_response(conn, 200) =~ "New Conversation"
    end
  end

  describe "create conversation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.conversation_path(conn, :create), conversation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.conversation_path(conn, :show, id)

      conn = get(conn, Routes.conversation_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Conversation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.conversation_path(conn, :create), conversation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Conversation"
    end
  end

  describe "edit conversation" do
    setup [:create_conversation]

    test "renders form for editing chosen conversation", %{conn: conn, conversation: conversation} do
      conn = get(conn, Routes.conversation_path(conn, :edit, conversation))
      assert html_response(conn, 200) =~ "Edit Conversation"
    end
  end

  describe "update conversation" do
    setup [:create_conversation]

    test "redirects when data is valid", %{conn: conn, conversation: conversation} do
      conn = put(conn, Routes.conversation_path(conn, :update, conversation), conversation: @update_attrs)
      assert redirected_to(conn) == Routes.conversation_path(conn, :show, conversation)

      conn = get(conn, Routes.conversation_path(conn, :show, conversation))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, conversation: conversation} do
      conn = put(conn, Routes.conversation_path(conn, :update, conversation), conversation: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Conversation"
    end
  end

  describe "delete conversation" do
    setup [:create_conversation]

    test "deletes chosen conversation", %{conn: conn, conversation: conversation} do
      conn = delete(conn, Routes.conversation_path(conn, :delete, conversation))
      assert redirected_to(conn) == Routes.conversation_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.conversation_path(conn, :show, conversation))
      end
    end
  end

  defp create_conversation(_) do
    conversation = conversation_fixture()
    %{conversation: conversation}
  end
end
