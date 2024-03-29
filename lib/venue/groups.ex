defmodule Venue.Groups do
  @moduledoc """
  The Groups context.
  """

  import Ecto.Query, warn: false
  import Geo.PostGIS
  alias Venue.Repo

  alias Venue.Groups.Group
  alias Venue.Groups.Comment
  alias Venue.Groups.Join
  alias Venue.Feeds.Feed
  alias Venue.Users

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_my_groups(conn) do
    if conn.assigns[:current_user] do
    c_user = Users.get_user!(conn.assigns.current_user.id)
    current_user = conn.assigns.current_user
    following = Enum.map(c_user.groups, fn member -> member.id end)

    """
    and p.id not in ^following and p.id not in ^skipped
    """

   query = from(p in Group, where: p.id in ^following, preload: :users)

    query
    |> Repo.all()

    else
    end

  end

  def list_groups(conn) do
    if conn.assigns[:current_user] do
    c_user = Users.get_user!(conn.assigns.current_user.id)
    current_user = conn.assigns.current_user
    following = Enum.map(c_user.groups, fn member -> member.id end)

    """
    and p.id not in ^following and p.id not in ^skipped
    """

   query = from(p in Group, where: st_distance_in_meters(p.geom, ^c_user.geom) < (^c_user.distance * 1000) and p.id not in ^following, preload: :users)

    query
    |> Repo.all()

    else
    end

  end

  def join_group(group, current_user) do
    %Join{:group_id => group, :user_id => current_user.id}
    |> Join.changeset()
    |> Repo.insert()

    g = get_group!(group)

    #g
    #|> Ecto.Changeset.change(%{popularity: g.popularity + 1})
    #|> Repo.update!()

    %Feed{:user_id => current_user.id, :type => 6, :data => "#{group}", :data2 => g.title}
    |> Repo.insert()
  end

  def quit_group(group, current_user) do
    quit = from(p in Join, where: p.user_id == ^current_user.id and p.group_id == ^group, select: p.id)

    #g = get_group!(group)

    #g
    #|> Ecto.Changeset.change(%{popularity: g.popularity - 1})
    #|> Repo.update!()

    quit
    |> Repo.delete_all()
   end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id) do
  query = from(p in Group, where: p.id == ^id, select: p,
  preload: [:users, :user, groups_comments: ^from(a in Comment, order_by: [desc: a.id], preload: [:user])]
)

Repo.one!(query)
end

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  def touch_group(%Group{} = group) do
    group
    |> Group.changeset()
    |> Repo.update()
  end

  @doc """
  Deletes a group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{data: %Group{}}

  """
  def change_group(%Group{} = group, attrs \\ %{}) do
    Group.changeset(group, attrs)
  end


  def add_group(current_user, group_params) do
    %{"city" => city} = group_params
    %{"title" => title} = group_params
    %{"desc" => desc} = group_params


    {:ok, coordinates } = Geocoder.call(city)
    lat = coordinates.lat
    long = coordinates.lon
    geom = %Geo.Point{coordinates: {lat, long}}

    %Group{:city => city, :geom => geom, :title => title, :desc => desc, :user_id => current_user.id}
      |> Group.changeset(%{city: city, geom: geom, title: title, desc: desc, user_id: current_user.id})
      |> Repo.insert()
  end


  def create_comment(%Group{} = group, current_user, attrs \\ %{}) do
    %{"message" => message} = attrs

    group
    |> Ecto.build_assoc(:groups_comments)
    |> Comment.changeset(%{message: message, user_id: current_user.id})
    |> Repo.insert()

    %Feed{:user_id => current_user.id, :type => 7, :data => "#{group.id}", :data2 => "#{group.title}"}
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
