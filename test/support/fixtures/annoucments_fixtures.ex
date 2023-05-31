defmodule Venue.AnnoucmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Venue.Annoucments` context.
  """

  @doc """
  Generate a help.
  """
  def help_fixture(attrs \\ %{}) do
    {:ok, help} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Venue.Annoucments.create_help()

    help
  end
end
