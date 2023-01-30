defmodule Venue.EventsTest do
  use Venue.DataCase

  alias Venue.Events

  describe "eventsatitletring" do
    alias Venue.Events.Event

    import Venue.EventsFixtures

    @invalid_attrs %{agdate: nil}

    test "list_eventsatitletring/0 returns all eventsatitletring" do
      event = event_fixture()
      assert Events.list_eventsatitletring() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{agdate: ~D[2023-01-04]}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.agdate == ~D[2023-01-04]
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{agdate: ~D[2023-01-05]}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.agdate == ~D[2023-01-05]
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "events" do
    alias Venue.Events.Event

    import Venue.EventsFixtures

    @invalid_attrs %{date: nil, title: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{date: ~N[2023-01-04 08:42:00], title: "some title"}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.date == ~N[2023-01-04 08:42:00]
      assert event.title == "some title"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{date: ~N[2023-01-05 08:42:00], title: "some updated title"}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.date == ~N[2023-01-05 08:42:00]
      assert event.title == "some updated title"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "comments" do
    alias Venue.Events.Comment

    import Venue.EventsFixtures

    @invalid_attrs %{message: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Events.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Events.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{message: "some message"}

      assert {:ok, %Comment{} = comment} = Events.create_comment(valid_attrs)
      assert comment.message == "some message"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{message: "some updated message"}

      assert {:ok, %Comment{} = comment} = Events.update_comment(comment, update_attrs)
      assert comment.message == "some updated message"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_comment(comment, @invalid_attrs)
      assert comment == Events.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Events.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Events.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Events.change_comment(comment)
    end
  end
end
