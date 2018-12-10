defmodule LockerWeb.LocalSessionController do
  use LockerWeb, :controller

  alias Locker.Sessions
  alias Locker.Sessions.LocalSession

  def index(conn, _params) do
    local_sessions = Sessions.list_local_sessions()
    render(conn, "index.html", local_sessions: local_sessions)
  end

  def new(conn, _params) do
    changeset = Sessions.change_local_session(%LocalSession{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"local_session" => local_session_params}) do
    case Sessions.create_local_session(local_session_params) do
      {:ok, local_session} ->
        conn
        |> put_flash(:info, "Local session created successfully.")
        |> redirect(to: Routes.local_session_path(conn, :show, local_session))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    local_session = Sessions.get_local_session!(id)
    render(conn, "show.html", local_session: local_session)
  end

  def edit(conn, %{"id" => id}) do
    local_session = Sessions.get_local_session!(id)
    changeset = Sessions.change_local_session(local_session)
    render(conn, "edit.html", local_session: local_session, changeset: changeset)
  end

  def update(conn, %{"id" => id, "local_session" => local_session_params}) do
    local_session = Sessions.get_local_session!(id)

    case Sessions.update_local_session(local_session, local_session_params) do
      {:ok, local_session} ->
        conn
        |> put_flash(:info, "Local session updated successfully.")
        |> redirect(to: Routes.local_session_path(conn, :show, local_session))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", local_session: local_session, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    local_session = Sessions.get_local_session!(id)
    {:ok, _local_session} = Sessions.delete_local_session(local_session)

    conn
    |> put_flash(:info, "Local session deleted successfully.")
    |> redirect(to: Routes.local_session_path(conn, :index))
  end
end
