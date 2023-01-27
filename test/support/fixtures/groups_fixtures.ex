defmodule Venue.GroupsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Venue.Groups` context.
  """

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Venue.Groups.create_group()

    group
  end
end
