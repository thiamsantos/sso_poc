defmodule Locker.ApplicattionsTest do
  use Locker.DataCase

  alias Locker.Applications

  describe "applications" do
    alias Locker.Applications.Application

    @valid_attrs %{domain: "some domain", name: "some name"}
    @update_attrs %{domain: "some updated domain", name: "some updated name"}
    @invalid_attrs %{domain: nil, name: nil}

    def applicattion_fixture(attrs \\ %{}) do
      {:ok, application} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Applications.create_applicattion()

      application
    end

    test "list_applicattions/0 returns all applications" do
      application = applicattion_fixture()
      assert Applications.list_applicattions() == [application]
    end

    test "get_applicattion!/1 returns the application with given id" do
      application = applicattion_fixture()
      assert Applications.get_applicattion!(application.id) == application
    end

    test "create_applicattion/1 with valid data creates a application" do
      assert {:ok, %Application{} = application} = Applications.create_applicattion(@valid_attrs)
      assert application.domain == "some domain"
      assert application.name == "some name"
    end

    test "create_applicattion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Applications.create_applicattion(@invalid_attrs)
    end

    test "update_applicattion/2 with valid data updates the application" do
      application = applicattion_fixture()

      assert {:ok, %Application{} = application} =
               Applications.update_applicattion(application, @update_attrs)

      assert application.domain == "some updated domain"
      assert application.name == "some updated name"
    end

    test "update_applicattion/2 with invalid data returns error changeset" do
      application = applicattion_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Applications.update_applicattion(application, @invalid_attrs)

      assert application == Applications.get_applicattion!(application.id)
    end

    test "delete_applicattion/1 deletes the application" do
      application = applicattion_fixture()
      assert {:ok, %Application{}} = Applications.delete_applicattion(application)
      assert_raise Ecto.NoResultsError, fn -> Applications.get_applicattion!(application.id) end
    end

    test "change_applicattion/1 returns a application changeset" do
      application = applicattion_fixture()
      assert %Ecto.Changeset{} = Applications.change_applicattion(application)
    end
  end
end
