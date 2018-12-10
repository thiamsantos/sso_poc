defmodule LockerWeb.UserApplicationController do
  use LockerWeb, :controller

  alias Locker.Accounts
  alias Locker.Applications
  alias Locker.Applications.UserApplication

  def index(conn, _params) do
    user_applications = Applications.list_user_applications()
    render(conn, "index.html", user_applications: user_applications)
  end

  def new(conn, _params) do
    changeset = Applications.change_user_applications(%UserApplication{})
    users = Accounts.list_users()
    applications = Applications.list_applications()

    render(conn, "new.html", changeset: changeset, applications: applications, users: users)
  end

  def create(conn, %{"user_application" => user_applications_params}) do
    case Applications.create_user_applications(user_applications_params) do
      {:ok, user_applications} ->
        conn
        |> put_flash(:info, "User applications created successfully.")
        |> redirect(to: Routes.user_application_path(conn, :show, user_applications))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_applications = Applications.get_user_applications!(id)
    render(conn, "show.html", user_applications: user_applications)
  end

  def edit(conn, %{"id" => id}) do
    user_applications = Applications.get_user_applications!(id)
    changeset = Applications.change_user_applications(user_applications)
    users = Accounts.list_users()
    applications = Applications.list_applications()

    render(conn, "edit.html",
      user_applications: user_applications,
      changeset: changeset,
      applications: applications,
      users: users
    )
  end

  def update(conn, %{"id" => id, "user_applications" => user_applications_params}) do
    user_applications = Applications.get_user_applications!(id)

    case Applications.update_user_applications(user_applications, user_applications_params) do
      {:ok, user_applications} ->
        conn
        |> put_flash(:info, "User applications updated successfully.")
        |> redirect(to: Routes.user_application_path(conn, :show, user_applications))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_applications: user_applications, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_applications = Applications.get_user_applications!(id)
    {:ok, _user_applications} = Applications.delete_user_applications(user_applications)

    conn
    |> put_flash(:info, "User applications deleted successfully.")
    |> redirect(to: Routes.user_application_path(conn, :index))
  end
end
