defmodule LockerWeb.LoginController do
  use LockerWeb, :controller

  alias Locker.{Accounts, Sessions}
  alias Locker.Accounts.{Credentials, User}

  def index(conn, _params) do
    IO.inspect(conn.resp_headers)
    changeset = Credentials.changeset(%Credentials{}, %{next_url: conn.query_params["next_url"]})

    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"credentials" => credentials}) do
    case Credentials.changeset(%Credentials{}, credentials) do
      %Ecto.Changeset{valid?: true} ->
        case Accounts.get_user(credentials["email"], credentials["password"]) do
          nil -> 
            conn
            |> put_flash(:info, "Invalid email or password!")
            |> redirect(to: Routes.login_path(conn, :index))

          %User{} = user ->
            IO.inspect(user)

            {:ok, session} = Sessions.create_global_session(%{user_id: user.id})
            IO.inspect(session)


            conn
            |> put_resp_cookie("_locker_session_id", session.id, domain: "localhost", http_only: true)
            |> redirect(external: credentials["next_url"])
        end

        %Ecto.Changeset{valid?: false} = changeset ->
        render(conn, "index.html", changeset: changeset)
    end
  end
end
