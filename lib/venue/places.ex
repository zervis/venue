defmodule Venue.Places do
  @moduledoc """
  The Places context.
  """

  import Ecto.Query, warn: false
  import Geo.PostGIS
  alias Venue.Repo

  alias Venue.Places.Place

  @doc """
  Returns the list of places.

  ## Examples

      iex> list_places()
      [%Place{}, ...]

  """
  def list_places(conn) do
    if conn.assigns[:current_user] do
   c_user = conn.assigns.current_user

   query = from(p in Place, where: st_distance_in_meters(p.geom, ^c_user.geom) < (^c_user.distance * 1000), order_by: [desc: :updated_at])

    query
    |> Repo.all()

    else
    end

  end

  @doc """
  Gets a single place.

  Raises `Ecto.NoResultsError` if the Place does not exist.

  ## Examples

      iex> get_place!(123)
      %Place{}

      iex> get_place!(456)
      ** (Ecto.NoResultsError)

  """
  def get_place!(id), do: Repo.get!(Place, id)

  @doc """
  Creates a place.

  ## Examples

      iex> create_place(%{field: value})
      {:ok, %Place{}}

      iex> create_place(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_place(attrs \\ %{}) do
    %Place{}
    |> Place.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a place.

  ## Examples

      iex> update_place(place, %{field: new_value})
      {:ok, %Place{}}

      iex> update_place(place, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_place(%Place{} = place, attrs) do
    place
    |> Place.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a place.

  ## Examples

      iex> delete_place(place)
      {:ok, %Place{}}

      iex> delete_place(place)
      {:error, %Ecto.Changeset{}}

  """
  def delete_place(%Place{} = place) do
    Repo.delete(place)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking place changes.

  ## Examples

      iex> change_place(place)
      %Ecto.Changeset{data: %Place{}}

  """
  def change_place(%Place{} = place, attrs \\ %{}) do
    Place.changeset(place, attrs)
  end

  def add_place(current_user, place_params) do
    %{"city" => city} = place_params
    %{"title" => title} = place_params
    %{"desc" => desc} = place_params


    {:ok, coordinates } = Geocoder.call(city)
    lat = coordinates.lat
    long = coordinates.lon
    geom = %Geo.Point{coordinates: {lat, long}}

    %Place{:city => city, :geom => geom, :title => title, :desc => desc, :user_id => current_user.id}
      |> Repo.insert()
  end

end
