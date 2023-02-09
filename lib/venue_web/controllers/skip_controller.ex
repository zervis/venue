defmodule VenueWeb.SkipController do
  use VenueWeb, :controller

  alias Venue.Skip.Skipped
  alias Venue.Users

  def create(conn, %{"users_id" => user_id}) do
    # define the post we are nested within
    user = Users.get_user!(user_id)
    current_user = conn.assigns.current_user

    # create our new comment and handle (success or failure)
    case Users.skip_user(user.id, current_user) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Skipped")
        |> redirect(to: Routes.users_path(conn, :index))

      # TODO: return to form and show errors
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Already skipped")
        |> redirect(to: Routes.users_path(conn, :index))
    end
  end

  def delete(conn, %{"users_id" => user_id}) do
    # define the post we are nested within
    user = Users.get_user!(user_id)
    current_user = conn.assigns.current_user

    # create our new comment and handle (success or failure)
    case Users.unskip_user(user.id, current_user) do
      {:error, _comment} ->
        conn
        |> put_flash(:info, "Unskipped")
        |> put_view(VenueWeb.UsersView)   # as of Phoenix 1.5.1
        |> render("show.html", user: user)

      # TODO: return to form and show errors
      _ ->
        conn
        |> put_flash(:info, "Unskipped")
        |> put_view(VenueWeb.UsersView)   # as of Phoenix 1.5.1
        |> render("show.html", user: user)
    end
  end

end
