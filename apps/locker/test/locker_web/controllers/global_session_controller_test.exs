defmodule LockerWeb.GlobalSessionControllerTest do
  use LockerWeb.ConnCase

  alias Locker.Sessions

  @create_attrs %{revoked_at: "2010-04-17T14:00:00Z"}
  @update_attrs %{revoked_at: "2011-05-18T15:01:01Z"}
  @invalid_attrs %{revoked_at: nil}

  def fixture(:global_session) do
    {:ok, global_session} = Sessions.create_global_session(@create_attrs)
    global_session
  end

  describe "index" do
    test "lists all global_sessions", %{conn: conn} do
      conn = get(conn, Routes.global_session_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Global sessions"
    end
  end

  describe "new global_session" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.global_session_path(conn, :new))
      assert html_response(conn, 200) =~ "New Global session"
    end
  end

  describe "create global_session" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.global_session_path(conn, :create), global_session: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.global_session_path(conn, :show, id)

      conn = get(conn, Routes.global_session_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Global session"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.global_session_path(conn, :create), global_session: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Global session"
    end
  end

  describe "edit global_session" do
    setup [:create_global_session]

    test "renders form for editing chosen global_session", %{
      conn: conn,
      global_session: global_session
    } do
      conn = get(conn, Routes.global_session_path(conn, :edit, global_session))
      assert html_response(conn, 200) =~ "Edit Global session"
    end
  end

  describe "update global_session" do
    setup [:create_global_session]

    test "redirects when data is valid", %{conn: conn, global_session: global_session} do
      conn =
        put(conn, Routes.global_session_path(conn, :update, global_session),
          global_session: @update_attrs
        )

      assert redirected_to(conn) == Routes.global_session_path(conn, :show, global_session)

      conn = get(conn, Routes.global_session_path(conn, :show, global_session))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, global_session: global_session} do
      conn =
        put(conn, Routes.global_session_path(conn, :update, global_session),
          global_session: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Global session"
    end
  end

  describe "delete global_session" do
    setup [:create_global_session]

    test "deletes chosen global_session", %{conn: conn, global_session: global_session} do
      conn = delete(conn, Routes.global_session_path(conn, :delete, global_session))
      assert redirected_to(conn) == Routes.global_session_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.global_session_path(conn, :show, global_session))
      end
    end
  end

  defp create_global_session(_) do
    global_session = fixture(:global_session)
    {:ok, global_session: global_session}
  end
end
