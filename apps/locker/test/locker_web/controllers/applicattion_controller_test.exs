defmodule LockerWeb.ApplicattionControllerTest do
  use LockerWeb.ConnCase

  alias Locker.Applications

  @create_attrs %{domain: "some domain", name: "some name"}
  @update_attrs %{domain: "some updated domain", name: "some updated name"}
  @invalid_attrs %{domain: nil, name: nil}

  def fixture(:application) do
    {:ok, application} = Applications.create_applicattion(@create_attrs)
    application
  end

  describe "index" do
    test "lists all applications", %{conn: conn} do
      conn = get(conn, Routes.applicattion_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Applications"
    end
  end

  describe "new application" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.applicattion_path(conn, :new))
      assert html_response(conn, 200) =~ "New Application"
    end
  end

  describe "create application" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.applicattion_path(conn, :create), application: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.applicattion_path(conn, :show, id)

      conn = get(conn, Routes.applicattion_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Application"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.applicattion_path(conn, :create), application: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Application"
    end
  end

  describe "edit application" do
    setup [:create_applicattion]

    test "renders form for editing chosen application", %{conn: conn, application: application} do
      conn = get(conn, Routes.applicattion_path(conn, :edit, application))
      assert html_response(conn, 200) =~ "Edit Application"
    end
  end

  describe "update application" do
    setup [:create_applicattion]

    test "redirects when data is valid", %{conn: conn, application: application} do
      conn =
        put(conn, Routes.applicattion_path(conn, :update, application), application: @update_attrs)

      assert redirected_to(conn) == Routes.applicattion_path(conn, :show, application)

      conn = get(conn, Routes.applicattion_path(conn, :show, application))
      assert html_response(conn, 200) =~ "some updated domain"
    end

    test "renders errors when data is invalid", %{conn: conn, application: application} do
      conn =
        put(conn, Routes.applicattion_path(conn, :update, application),
          application: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Application"
    end
  end

  describe "delete application" do
    setup [:create_applicattion]

    test "deletes chosen application", %{conn: conn, application: application} do
      conn = delete(conn, Routes.applicattion_path(conn, :delete, application))
      assert redirected_to(conn) == Routes.applicattion_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.applicattion_path(conn, :show, application))
      end
    end
  end

  defp create_applicattion(_) do
    application = fixture(:application)
    {:ok, application: application}
  end
end
