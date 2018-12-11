defmodule LockerWeb.API.SessionController do
  use LockerWeb, :controller

  alias Locker.Sessions
  alias Locker.Sessions.GlobalSession

  def validate(conn, %{"session_id" => session_id}) when is_binary(session_id) do
    case Sessions.get_global_session(session_id) do
      nil -> 
        conn
        |> put_status(:not_found)
        |> json(%{error: "Session ID not found"})

      %GlobalSession{} = global_session ->
        conn
        |> put_status(200)
        |> json(%{data: %{user_id: global_session.user_id}})
        
    end
  end

  def validate(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Invalid or missing parameters"})
  end

  def logout(conn, %{"next_url" => next_url}) do
    session_id = Map.get(conn.cookies, "_locker_session_id")

    {1, _} = Sessions.revoke_global_session(session_id)

    conn
    |> delete_resp_cookie("_locker_session_id", domain: "localhost", http_only: true)
    |> redirect(external: next_url)
  end
end