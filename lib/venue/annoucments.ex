defmodule Venue.Annoucments do
  @moduledoc """
  The Annoucments context.
  """

  import Ecto.Query, warn: false
  alias Venue.Repo
  import Geo.PostGIS
  alias Venue.Users

  alias Venue.Annoucments.Help
  alias Venue.Annoucments.Comment

  @doc """
  Returns the list of annoucments.

  ## Examples

      iex> list_annoucments()
      [%Help{}, ...]


  def list_annoucments do
    Repo.all(Help)
  end
    """

  def list_annoucments(conn) do
    if conn.assigns[:current_user] do
    c_user = Users.get_user!(conn.assigns.current_user.id)
    current_user = conn.assigns.current_user

    """
    and p.id not in ^following and p.id not in ^skipped
    """

   query = from(p in Help, where: st_distance_in_meters(p.geom, ^c_user.geom) < (^c_user.distance * 1000), order_by: [desc: :inserted_at], preload: :users)

    query
    |> Repo.all()

    else
    end

  end

  @doc """
  Gets a single help.

  Raises `Ecto.NoResultsError` if the Help does not exist.

  ## Examples

      iex> get_help!(123)
      %Help{}

      iex> get_help!(456)
      ** (Ecto.NoResultsError)

  """
  def get_help!(id) do
    query = from(p in Help, where: p.id == ^id, select: p,
    preload: [:users, :user, help_comments: ^from(a in Comment, order_by: [asc: a.id], preload: [:user])]
  )

  Repo.one!(query)
  end

  @doc """
  Creates a help.

  ## Examples

      iex> create_help(%{field: value})
      {:ok, %Help{}}

      iex> create_help(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_help(current_user, help_params) do
    %{"description" => description} = help_params
    city = current_user.city

    {:ok, coordinates } = Geocoder.call(city)
    lat = coordinates.lat
    long = coordinates.lon
    geom = %Geo.Point{coordinates: {lat, long}}

    %Help{:city => city, :geom => geom, :description => description, :user_id => current_user.id}
      |> Help.changeset(%{city: city, geom: geom, description: description, user_id: current_user.id})
      |> Repo.insert()
  end

  def create_comment(%Help{} = help, current_user, attrs \\ %{}) do
    %{"message" => message} = attrs

    help
    |> Ecto.build_assoc(:help_comments)
    |> Comment.changeset(%{message: message, user_id: current_user.id})
    |> Repo.insert()
  end

  @doc """
  Updates a help.

  ## Examples

      iex> update_help(help, %{field: new_value})
      {:ok, %Help{}}

      iex> update_help(help, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_help(%Help{} = help, attrs) do
    help
    |> Help.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a help.

  ## Examples

      iex> delete_help(help)
      {:ok, %Help{}}

      iex> delete_help(help)
      {:error, %Ecto.Changeset{}}

  """
  def delete_help(%Help{} = help) do
    Repo.delete(help)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking help changes.

  ## Examples

      iex> change_help(help)
      %Ecto.Changeset{data: %Help{}}

  """
  def change_help(%Help{} = help, attrs \\ %{}) do
    Help.changeset(help, attrs)
  end

  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end

end
