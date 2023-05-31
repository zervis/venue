defmodule VenueWeb.HelpController do
  use VenueWeb, :controller

  alias Venue.Annoucments
  alias Venue.Annoucments.Help
  alias Venue.Annoucments.Comment
  alias Venue.Users

  def index(conn, _params) do
    annoucments = Annoucments.list_annoucments(conn)
    render(conn, "index.html", annoucments: annoucments)
  end

  def new(conn, _params) do
    changeset = Annoucments.change_help(%Help{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"help" => help_params}) do
      current_user = conn.assigns.current_user

      case Annoucments.create_help(current_user, help_params) do
          {:ok, help} ->
              conn
              |> put_flash(:info, "Added help!")
              |> redirect(to: Routes.help_path(conn, :show, help.id))
          {:error, _error} ->
              conn
              |> put_flash(:error, "oopsie")
              |> redirect(to: Routes.help_path(conn, :new))
      end

  end


 def show(conn, %{"id" => id}) do
    help = Annoucments.get_help!(id)
    users = Users.list_users(conn)
    comment_changeset = Annoucments.change_comment(%Comment{})
    render(conn, "show.html", help: help, users: users, comment_changeset: comment_changeset)
  end

  def edit(conn, %{"id" => id}) do
    help = Annoucments.get_help!(id)
    changeset = Annoucments.change_help(help)
    render(conn, "edit.html", help: help, changeset: changeset)
  end

  def update(conn, %{"id" => id, "help" => help_params}) do
    help = Annoucments.get_help!(id)

    case Annoucments.update_help(help, help_params) do
      {:ok, help} ->
        conn
        |> put_flash(:info, "Help updated successfully.")
        |> redirect(to: Routes.help_path(conn, :show, help))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", help: help, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    help = Annoucments.get_help!(id)
    {:ok, _help} = Annoucments.delete_help(help)

    conn
    |> put_flash(:info, "Help deleted successfully.")
    |> redirect(to: Routes.help_path(conn, :index))
  end
end
