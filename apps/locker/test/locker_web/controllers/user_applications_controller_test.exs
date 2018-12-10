defmodule LockerWeb.UserApplicationControllerTest do
  use LockerWeb.ConnCase

  alias Locker.Applications

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:user_applications) do
    {:ok, user_applications} = Applications.create_user_applications(@create_attrs)
    user_applications
  end

  describe "index" do
    test "lists all user_applications", %{conn: conn} do
      conn = get(conn, Routes.user_application_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing User applications"
    end
  end

  describe "new user_applications" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_application_path(conn, :new))
      assert html_response(conn, 200) =~ "New User applications"
    end
  end

  describe "create user_applications" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.user_application_path(conn, :create), user_applications: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_application_path(conn, :show, id)

      conn = get(conn, Routes.user_application_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show User applications"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.user_application_path(conn, :create), user_applications: @invalid_attrs)

      assert html_response(conn, 200) =~ "New User applications"
    end
  end

  describe "edit user_applications" do
    setup [:create_user_applications]

    test "renders form for editing chosen user_applications", %{
      conn: conn,
      user_applications: user_applications
    } do
      conn = get(conn, Routes.user_application_path(conn, :edit, user_applications))
      assert html_response(conn, 200) =~ "Edit User applications"
    end
  end

  describe "update user_applications" do
    setup [:create_user_applications]

    test "redirects when data is valid", %{conn: conn, user_applications: user_applications} do
      conn =
        put(conn, Routes.user_application_path(conn, :update, user_applications),
          user_applications: @update_attrs
        )

      assert redirected_to(conn) == Routes.user_application_path(conn, :show, user_applications)

      conn = get(conn, Routes.user_application_path(conn, :show, user_applications))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      user_applications: user_applications
    } do
      conn =
        put(conn, Routes.user_application_path(conn, :update, user_applications),
          user_applications: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit User applications"
    end
  end

  describe "delete user_applications" do
    setup [:create_user_applications]

    test "deletes chosen user_applications", %{conn: conn, user_applications: user_applications} do
      conn = delete(conn, Routes.user_application_path(conn, :delete, user_applications))
      assert redirected_to(conn) == Routes.user_application_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_application_path(conn, :show, user_applications))
      end
    end
  end

  defp create_user_applications(_) do
    user_applications = fixture(:user_applications)
    {:ok, user_applications: user_applications}
  end
end
