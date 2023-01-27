defmodule Venue.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Venue.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        agdate: ~D[2023-01-04]
      })
      |> Venue.Events.create_event()

    event
  end

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        date: ~N[2023-01-04 08:42:00],
        title: "some title"
      })
      |> Venue.Events.create_event()

    event
  end
end
