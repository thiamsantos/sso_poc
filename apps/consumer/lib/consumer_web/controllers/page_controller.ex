defmodule ConsumerWeb.PageController do
  use ConsumerWeb, :controller

  @locker_url "http://localhost:4000/login"
  @locker_session_validation "http://localhost:4000/api/session/validate"
  @locker_session_logout "http://localhost:4000/session/logout"

  def index(conn, _params) do
    conn.resp_headers |> IO.inspect()
    session_id = Map.get(conn.cookies, "_locker_session_id")

    case validate_session(session_id) do
      {:ok, %{"data" => %{"user_id" => user_id}}} ->
        render(conn, "index.html", user_id: user_id)

      {:error, :invalid_session} ->
        next = URI.to_string(%URI{scheme: to_string(conn.scheme), host: conn.host, port: conn.port, path: conn.request_path, query: conn.query_string})
        query = URI.encode_query(%{"next_url" => next})
    
        redirect_url = @locker_url
        |> URI.parse()
        |> Map.put(:query, query)
        |> URI.to_string()
    
        redirect(conn, external: redirect_url)
    end
  end


  def logout(conn, _params) do
    next = URI.to_string(%URI{scheme: to_string(conn.scheme), host: conn.host, port: conn.port, path: "/user"})
    query = URI.encode_query(%{"next_url" => next})

    redirect_url = @locker_session_logout
    |> URI.parse()
    |> Map.put(:query, query)
    |> URI.to_string()

    redirect(conn, external: redirect_url)
  end

  defp validate_session(session_id) do
    body = Jason.encode!(%{session_id: session_id})

    case HTTPoison.post(@locker_session_validation, body, [{"Content-Type", "application/json"}]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Jason.decode!(body)}
      _ -> {:error, :invalid_session}
    end
  end
end
