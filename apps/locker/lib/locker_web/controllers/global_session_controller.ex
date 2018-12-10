defmodule LockerWeb.GlobalSessionController do
  use LockerWeb, :controller

  alias Locker.Sessions
  alias Locker.Sessions.GlobalSession
  alias Locker.Accounts

  def index(conn, _params) do
    global_sessions = Sessions.list_global_sessions()
    render(conn, "index.html", global_sessions: global_sessions)
  end

  def new(conn, _params) do
    changeset = Sessions.change_global_session(%GlobalSession{})
    users = Accounts.list_users()
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"global_session" => global_session_params}) do
    case Sessions.create_global_session(global_session_params) do
      {:ok, global_session} ->
        conn
        |> put_flash(:info, "Global session created successfully.")
        |> redirect(to: Routes.global_session_path(conn, :show, global_session))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    global_session = Sessions.get_global_session!(id)
    render(conn, "show.html", global_session: global_session)
  end

  def edit(conn, %{"id" => id}) do
    global_session = Sessions.get_global_session!(id)
    users = Accounts.list_users()

    changeset = Sessions.change_global_session(global_session)
    render(conn, "edit.html", global_session: global_session, users: users, changeset: changeset)
  end

  def update(conn, %{"id" => id, "global_session" => global_session_params}) do
    global_session = Sessions.get_global_session!(id)

    case Sessions.update_global_session(global_session, global_session_params) do
      {:ok, global_session} ->
        conn
        |> put_flash(:info, "Global session updated successfully.")
        |> redirect(to: Routes.global_session_path(conn, :show, global_session))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", global_session: global_session, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    global_session = Sessions.get_global_session!(id)
    {:ok, _global_session} = Sessions.delete_global_session(global_session)

    conn
    |> put_flash(:info, "Global session deleted successfully.")
    |> redirect(to: Routes.global_session_path(conn, :index))
  end
end
