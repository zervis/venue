defmodule Venue.PlacesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Venue.Places` context.
  """

  @doc """
  Generate a place.
  """
  def place_fixture(attrs \\ %{}) do
    {:ok, place} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Venue.Places.create_place()

    place
  end
end
