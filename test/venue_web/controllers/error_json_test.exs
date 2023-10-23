defmodule VenueWeb.ErrorJSONTest do
  use VenueWeb.ConnCase, async: true

  test "renders 404" do
    assert VenueWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert VenueWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
