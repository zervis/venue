defmodule Venue.Places do
  @moduledoc """
  The Places context.
  """

  import Ecto.Query, warn: false
  import Geo.PostGIS
  alias Venue.Repo

  alias Venue.Places.Place
  alias Venue.Places.Comment

  @doc """
  Returns the list of places.

  ## Examples

      iex> list_places()
      [%Place{}, ...]

  """
  def list_places(conn) do
    if conn.assigns[:current_user] do
   c_user = conn.assigns.current_user

   query = from(p in Place, where: st_distance_in_meters(p.geom, ^c_user.geom) < (^c_user.distance * 1000), order_by: [desc: :updated_at], preload: :user)

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
  def get_place!(id) do
    query = from(p in Place, where: p.id == ^id, select: p,
    preload: [:user, places_comments: ^from(a in Comment, order_by: [desc: a.id], preload: [:user])]
  )

  Repo.one!(query)
  end
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
    %{"avatar" => avatar} = place_params


    {:ok, coordinates } = Geocoder.call(city)
    lat = coordinates.lat
    long = coordinates.lon
    geom = %Geo.Point{coordinates: {lat, long}}

    attrs = %{city: city, geom: geom, title: title, user_id: current_user.id}
    attrs2 = %{avatar: avatar}

    Ecto.Multi.new()
    |> Ecto.Multi.insert(:place, Place.changeset(%Place{}, attrs))
    |> Ecto.Multi.update(:place_with_photo, &Place.photo_changeset(&1.place, attrs2))
    |> Repo.transaction()
    |> case do
      {:ok, %{place_with_photo: place}} -> {:ok, place}
      {:error, _, changeset, _} -> {:error, changeset}
    end

   # %Place{}
   #   |> Place.changeset(%{city: city, geom: geom, title: title, user_id: current_user.id})
   #  |> Repo.insert()

  end

  def create_comment(%Place{} = place, current_user, attrs \\ %{}) do
    %{"message" => message} = attrs

    place
    |> Ecto.build_assoc(:places_comments)
    |> Comment.changeset(%{message: message, user_id: current_user.id})
    |> Repo.insert()
  end



  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end
