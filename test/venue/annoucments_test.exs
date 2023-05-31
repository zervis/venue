defmodule Venue.AnnoucmentsTest do
  use Venue.DataCase

  alias Venue.Annoucments

  describe "annoucments" do
    alias Venue.Annoucments.Help

    import Venue.AnnoucmentsFixtures

    @invalid_attrs %{description: nil, title: nil}

    test "list_annoucments/0 returns all annoucments" do
      help = help_fixture()
      assert Annoucments.list_annoucments() == [help]
    end

    test "get_help!/1 returns the help with given id" do
      help = help_fixture()
      assert Annoucments.get_help!(help.id) == help
    end

    test "create_help/1 with valid data creates a help" do
      valid_attrs = %{description: "some description", title: "some title"}

      assert {:ok, %Help{} = help} = Annoucments.create_help(valid_attrs)
      assert help.description == "some description"
      assert help.title == "some title"
    end

    test "create_help/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Annoucments.create_help(@invalid_attrs)
    end

    test "update_help/2 with valid data updates the help" do
      help = help_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title"}

      assert {:ok, %Help{} = help} = Annoucments.update_help(help, update_attrs)
      assert help.description == "some updated description"
      assert help.title == "some updated title"
    end

    test "update_help/2 with invalid data returns error changeset" do
      help = help_fixture()
      assert {:error, %Ecto.Changeset{}} = Annoucments.update_help(help, @invalid_attrs)
      assert help == Annoucments.get_help!(help.id)
    end

    test "delete_help/1 deletes the help" do
      help = help_fixture()
      assert {:ok, %Help{}} = Annoucments.delete_help(help)
      assert_raise Ecto.NoResultsError, fn -> Annoucments.get_help!(help.id) end
    end

    test "change_help/1 returns a help changeset" do
      help = help_fixture()
      assert %Ecto.Changeset{} = Annoucments.change_help(help)
    end
  end
end
