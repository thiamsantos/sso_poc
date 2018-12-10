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
end