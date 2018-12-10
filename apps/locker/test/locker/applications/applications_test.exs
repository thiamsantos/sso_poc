defmodule Locker.ApplicationsTest do
  use Locker.DataCase

  alias Locker.Applications

  describe "user_applications" do
    alias Locker.Applications.UserApplication

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_applications_fixture(attrs \\ %{}) do
      {:ok, user_applications} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Applications.create_user_applications()

      user_applications
    end

    test "list_user_applications/0 returns all user_applications" do
      user_applications = user_applications_fixture()
      assert Applications.list_user_applications() == [user_applications]
    end

    test "get_user_applications!/1 returns the user_applications with given id" do
      user_applications = user_applications_fixture()
      assert Applications.get_user_applications!(user_applications.id) == user_applications
    end

    test "create_user_applications/1 with valid data creates a user_applications" do
      assert {:ok, %UserApplication{} = user_applications} =
               Applications.create_user_applications(@valid_attrs)
    end

    test "create_user_applications/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Applications.create_user_applications(@invalid_attrs)
    end

    test "update_user_applications/2 with valid data updates the user_applications" do
      user_applications = user_applications_fixture()

      assert {:ok, %UserApplication{} = user_applications} =
               Applications.update_user_applications(user_applications, @update_attrs)
    end

    test "update_user_applications/2 with invalid data returns error changeset" do
      user_applications = user_applications_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Applications.update_user_applications(user_applications, @invalid_attrs)

      assert user_applications == Applications.get_user_applications!(user_applications.id)
    end

    test "delete_user_applications/1 deletes the user_applications" do
      user_applications = user_applications_fixture()
      assert {:ok, %UserApplication{}} = Applications.delete_user_applications(user_applications)

      assert_raise Ecto.NoResultsError, fn ->
        Applications.get_user_applications!(user_applications.id)
      end
    end

    test "change_user_applications/1 returns a user_applications changeset" do
      user_applications = user_applications_fixture()
      assert %Ecto.Changeset{} = Applications.change_user_applications(user_applications)
    end
  end
end
