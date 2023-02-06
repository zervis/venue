defmodule Venue.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  import Geo.PostGIS
  alias Venue.Repo

  alias Venue.Events.Event
  alias Venue.Events.Comment

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events(conn) do
    if conn.assigns[:current_user] do
   c_user = conn.assigns.current_user
   current_date = Timex.now()

   query = from(p in Event, where: p.date > ^current_date, where: st_distance_in_meters(p.geom, ^c_user.geom) < (^c_user.distance * 1000), order_by: [asc: :date])

    query
    |> Repo.all()

    else
    end

  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id) do

    query = from(p in Event, where: p.id == ^id, select: p,
      preload: [:user, comments: ^from(a in Comment, order_by: [desc: a.id], preload: [:user])]
    )

  Repo.one!(query)
end

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change_event(%Event{} = event, attrs \\ %{}) do
    Event.changeset(event, attrs)
  end

  def add_event(current_user, event_params) do
    %{"city" => city} = event_params
    %{"date" => date} = event_params
    %{"hour" => hour} = event_params
    %{"title" => title} = event_params
    %{"desc" => desc} = event_params

    date_with_time = date <> " " <> hour <> ":00"

    {:ok, naive_date} = NaiveDateTime.from_iso8601(date_with_time)


    {:ok, coordinates } = Geocoder.call(city)
    lat = coordinates.lat
    long = coordinates.lon
    geom = %Geo.Point{coordinates: {lat, long}}

    %Event{}
      |> Event.changeset(%{city: city, geom: geom, title: title, desc: desc, date: naive_date, user_id: current_user.id})
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
  def create_comment(%Event{} = event, current_user, attrs \\ %{}) do
    %{"message" => message} = attrs

    event
    |> Ecto.build_assoc(:comments)
    |> Comment.changeset(%{message: message, user_id: current_user.id})
    |> Repo.insert()
  end

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
