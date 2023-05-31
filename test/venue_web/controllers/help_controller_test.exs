defmodule VenueWeb.HelpControllerTest do
  use VenueWeb.ConnCase

  import Venue.AnnoucmentsFixtures

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{description: "some updated description", title: "some updated title"}
  @invalid_attrs %{description: nil, title: nil}

  describe "index" do
    test "lists all annoucments", %{conn: conn} do
      conn = get(conn, Routes.help_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Annoucments"
    end
  end

  describe "new help" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.help_path(conn, :new))
      assert html_response(conn, 200) =~ "New Help"
    end
  end

  describe "create help" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.help_path(conn, :create), help: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.help_path(conn, :show, id)

      conn = get(conn, Routes.help_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Help"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.help_path(conn, :create), help: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Help"
    end
  end

  describe "edit help" do
    setup [:create_help]

    test "renders form for editing chosen help", %{conn: conn, help: help} do
      conn = get(conn, Routes.help_path(conn, :edit, help))
      assert html_response(conn, 200) =~ "Edit Help"
    end
  end

  describe "update help" do
    setup [:create_help]

    test "redirects when data is valid", %{conn: conn, help: help} do
      conn = put(conn, Routes.help_path(conn, :update, help), help: @update_attrs)
      assert redirected_to(conn) == Routes.help_path(conn, :show, help)

      conn = get(conn, Routes.help_path(conn, :show, help))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, help: help} do
      conn = put(conn, Routes.help_path(conn, :update, help), help: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Help"
    end
  end

  describe "delete help" do
    setup [:create_help]

    test "deletes chosen help", %{conn: conn, help: help} do
      conn = delete(conn, Routes.help_path(conn, :delete, help))
      assert redirected_to(conn) == Routes.help_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.help_path(conn, :show, help))
      end
    end
  end

  defp create_help(_) do
    help = help_fixture()
    %{help: help}
  end
end
