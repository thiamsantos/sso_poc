defmodule LockerWeb.LocalSessionControllerTest do
  use LockerWeb.ConnCase

  alias Locker.Sessions

  @create_attrs %{revoked_at: "2010-04-17T14:00:00Z"}
  @update_attrs %{revoked_at: "2011-05-18T15:01:01Z"}
  @invalid_attrs %{revoked_at: nil}

  def fixture(:local_session) do
    {:ok, local_session} = Sessions.create_local_session(@create_attrs)
    local_session
  end

  describe "index" do
    test "lists all local_sessions", %{conn: conn} do
      conn = get(conn, Routes.local_session_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Local sessions"
    end
  end

  describe "new local_session" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.local_session_path(conn, :new))
      assert html_response(conn, 200) =~ "New Local session"
    end
  end

  describe "create local_session" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.local_session_path(conn, :create), local_session: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.local_session_path(conn, :show, id)

      conn = get(conn, Routes.local_session_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Local session"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.local_session_path(conn, :create), local_session: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Local session"
    end
  end

  describe "edit local_session" do
    setup [:create_local_session]

    test "renders form for editing chosen local_session", %{
      conn: conn,
      local_session: local_session
    } do
      conn = get(conn, Routes.local_session_path(conn, :edit, local_session))
      assert html_response(conn, 200) =~ "Edit Local session"
    end
  end

  describe "update local_session" do
    setup [:create_local_session]

    test "redirects when data is valid", %{conn: conn, local_session: local_session} do
      conn =
        put(conn, Routes.local_session_path(conn, :update, local_session),
          local_session: @update_attrs
        )

      assert redirected_to(conn) == Routes.local_session_path(conn, :show, local_session)

      conn = get(conn, Routes.local_session_path(conn, :show, local_session))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, local_session: local_session} do
      conn =
        put(conn, Routes.local_session_path(conn, :update, local_session),
          local_session: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Local session"
    end
  end

  describe "delete local_session" do
    setup [:create_local_session]

    test "deletes chosen local_session", %{conn: conn, local_session: local_session} do
      conn = delete(conn, Routes.local_session_path(conn, :delete, local_session))
      assert redirected_to(conn) == Routes.local_session_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.local_session_path(conn, :show, local_session))
      end
    end
  end

  defp create_local_session(_) do
    local_session = fixture(:local_session)
    {:ok, local_session: local_session}
  end
end
