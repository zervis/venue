defmodule VenueWeb.PlacesController do
  use VenueWeb, :controller

  alias Venue.Places
  alias Venue.Places.Place
  
  def index(conn, _params) do
    places = Places.list_places(conn)
    render(conn, "index.html", places: places)
  end

  def new(conn, _params) do
		changeset = Places.change_place(%Place{})
		render(conn, "new.html", changeset: changeset)
	end

  def add_place(conn, %{"place" => place_params}) do
    current_user = conn.assigns.current_user

    case Places.add_place(current_user, place_params) do
        {:ok, _place} ->
            conn
            |> put_flash(:info, "Added place!")
            |> redirect(to: Routes.places_path(conn, :index))
        {:error, _error} ->
            conn
            |> put_flash(:error, "oopsie")
            |> redirect(to: Routes.places_path(conn, :new))
    end
  end

end
