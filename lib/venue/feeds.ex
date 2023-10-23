defmodule Venue.Feeds do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Venue.Repo

  alias Venue.Accounts
  alias Venue.Feeds.Feed

  def list_activities(conn) do
    if conn.assigns[:current_user] do
      current_user = conn.assigns.current_user
      c_user = Accounts.get_user!(conn.assigns.current_user.id)

      following = Enum.map(c_user.relationships, fn member -> member.id end)
      reverse_following = Enum.map(c_user.reverse_relationships, fn member -> member.id end)
      ## and p.user_id in ^reverse_following
      query =
        from(p in Feed,
          where: p.user_id != ^current_user.id and p.user_id in ^following,
          order_by: [desc: :updated_at],
          preload: [:user, :relation]
        )

      query
      |> Repo.all()
    else
    end
  end

  def list_invite(conn) do
    if conn.assigns[:current_user] do
      current_user = conn.assigns.current_user
      c_user = Accounts.get_user!(conn.assigns.current_user.id)

      reverse_following = Enum.map(c_user.reverse_relationships, fn member -> member.id end)

      query =
        from(p in Feed,
          where:
            p.type == 1 and p.user_id != ^current_user.id and p.relation_id in ^reverse_following,
          order_by: [desc: :updated_at],
          preload: [:user, :relation],
          limit: 5
        )

      query
      |> Repo.all()
    else
    end
  end
end
