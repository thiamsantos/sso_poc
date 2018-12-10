defmodule Locker.SessionsTest do
  use Locker.DataCase

  alias Locker.Sessions

  describe "global_sessions" do
    alias Locker.Sessions.GlobalSession

    @valid_attrs %{revoked_at: "2010-04-17T14:00:00Z"}
    @update_attrs %{revoked_at: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{revoked_at: nil}

    def global_session_fixture(attrs \\ %{}) do
      {:ok, global_session} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sessions.create_global_session()

      global_session
    end

    test "list_global_sessions/0 returns all global_sessions" do
      global_session = global_session_fixture()
      assert Sessions.list_global_sessions() == [global_session]
    end

    test "get_global_session!/1 returns the global_session with given id" do
      global_session = global_session_fixture()
      assert Sessions.get_global_session!(global_session.id) == global_session
    end

    test "create_global_session/1 with valid data creates a global_session" do
      assert {:ok, %GlobalSession{} = global_session} =
               Sessions.create_global_session(@valid_attrs)

      assert global_session.revoked_at ==
               DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_global_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sessions.create_global_session(@invalid_attrs)
    end

    test "update_global_session/2 with valid data updates the global_session" do
      global_session = global_session_fixture()

      assert {:ok, %GlobalSession{} = global_session} =
               Sessions.update_global_session(global_session, @update_attrs)

      assert global_session.revoked_at ==
               DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_global_session/2 with invalid data returns error changeset" do
      global_session = global_session_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Sessions.update_global_session(global_session, @invalid_attrs)

      assert global_session == Sessions.get_global_session!(global_session.id)
    end

    test "delete_global_session/1 deletes the global_session" do
      global_session = global_session_fixture()
      assert {:ok, %GlobalSession{}} = Sessions.delete_global_session(global_session)
      assert_raise Ecto.NoResultsError, fn -> Sessions.get_global_session!(global_session.id) end
    end

    test "change_global_session/1 returns a global_session changeset" do
      global_session = global_session_fixture()
      assert %Ecto.Changeset{} = Sessions.change_global_session(global_session)
    end
  end

  describe "local_sessions" do
    alias Locker.Sessions.LocalSession

    @valid_attrs %{revoked_at: "2010-04-17T14:00:00Z"}
    @update_attrs %{revoked_at: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{revoked_at: nil}

    def local_session_fixture(attrs \\ %{}) do
      {:ok, local_session} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sessions.create_local_session()

      local_session
    end

    test "list_local_sessions/0 returns all local_sessions" do
      local_session = local_session_fixture()
      assert Sessions.list_local_sessions() == [local_session]
    end

    test "get_local_session!/1 returns the local_session with given id" do
      local_session = local_session_fixture()
      assert Sessions.get_local_session!(local_session.id) == local_session
    end

    test "create_local_session/1 with valid data creates a local_session" do
      assert {:ok, %LocalSession{} = local_session} = Sessions.create_local_session(@valid_attrs)
      assert local_session.revoked_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_local_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sessions.create_local_session(@invalid_attrs)
    end

    test "update_local_session/2 with valid data updates the local_session" do
      local_session = local_session_fixture()

      assert {:ok, %LocalSession{} = local_session} =
               Sessions.update_local_session(local_session, @update_attrs)

      assert local_session.revoked_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_local_session/2 with invalid data returns error changeset" do
      local_session = local_session_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Sessions.update_local_session(local_session, @invalid_attrs)

      assert local_session == Sessions.get_local_session!(local_session.id)
    end

    test "delete_local_session/1 deletes the local_session" do
      local_session = local_session_fixture()
      assert {:ok, %LocalSession{}} = Sessions.delete_local_session(local_session)
      assert_raise Ecto.NoResultsError, fn -> Sessions.get_local_session!(local_session.id) end
    end

    test "change_local_session/1 returns a local_session changeset" do
      local_session = local_session_fixture()
      assert %Ecto.Changeset{} = Sessions.change_local_session(local_session)
    end
  end
end
