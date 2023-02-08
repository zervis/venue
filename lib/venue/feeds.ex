defmodule Venue.Feeds do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Venue.Repo

  alias Venue.Users
  alias Venue.Feeds.Feed

  def list_activities(conn) do
    if conn.assigns[:current_user] do
    current_user = conn.assigns.current_user
    c_user = Users.get_user!(conn.assigns.current_user.id)

   following = Enum.map(c_user.reverse_relationships, fn member -> member.id end)
   query = from(p in Feed, where: p.user_id != ^current_user.id and p.user_id in ^following, order_by: [desc: :updated_at], preload: :user)

    query
    |> Repo.all()

    else
    end

  end
end
