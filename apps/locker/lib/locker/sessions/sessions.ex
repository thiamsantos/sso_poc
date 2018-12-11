defmodule Locker.Sessions do
  @moduledoc """
  The Sessions context.
  """

  import Ecto.Query, warn: false
  alias Locker.Repo

  alias Locker.Sessions.GlobalSession

  @doc """
  Returns the list of global_sessions.

  ## Examples

      iex> list_global_sessions()
      [%GlobalSession{}, ...]

  """
  def list_global_sessions do
    Repo.all(GlobalSession)
  end

  @doc """
  Gets a single global_session.

  Raises `Ecto.NoResultsError` if the Global session does not exist.

  ## Examples

      iex> get_global_session!(123)
      %GlobalSession{}

      iex> get_global_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_global_session!(id), do: Repo.get!(GlobalSession, id)
  def get_global_session(id), do: Repo.get(GlobalSession, id)

  @doc """
  Creates a global_session.

  ## Examples

      iex> create_global_session(%{field: value})
      {:ok, %GlobalSession{}}

      iex> create_global_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_global_session(attrs \\ %{}) do
    %GlobalSession{}
    |> GlobalSession.changeset(attrs)
    |> Repo.insert()
  end

  def revoke_global_session(session_id) do
    date = DateTime.utc_now()
    query = from(s in GlobalSession, where: s.id == ^session_id)
    
    Repo.update_all(query, set: [revoked_at: date])
  end

  @doc """
  Updates a global_session.

  ## Examples

      iex> update_global_session(global_session, %{field: new_value})
      {:ok, %GlobalSession{}}

      iex> update_global_session(global_session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_global_session(%GlobalSession{} = global_session, attrs) do
    global_session
    |> GlobalSession.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a GlobalSession.

  ## Examples

      iex> delete_global_session(global_session)
      {:ok, %GlobalSession{}}

      iex> delete_global_session(global_session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_global_session(%GlobalSession{} = global_session) do
    Repo.delete(global_session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking global_session changes.

  ## Examples

      iex> change_global_session(global_session)
      %Ecto.Changeset{source: %GlobalSession{}}

  """
  def change_global_session(%GlobalSession{} = global_session) do
    GlobalSession.changeset(global_session, %{})
  end

  alias Locker.Sessions.LocalSession

  @doc """
  Returns the list of local_sessions.

  ## Examples

      iex> list_local_sessions()
      [%LocalSession{}, ...]

  """
  def list_local_sessions do
    Repo.all(LocalSession)
  end

  @doc """
  Gets a single local_session.

  Raises `Ecto.NoResultsError` if the Local session does not exist.

  ## Examples

      iex> get_local_session!(123)
      %LocalSession{}

      iex> get_local_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_local_session!(id), do: Repo.get!(LocalSession, id)

  @doc """
  Creates a local_session.

  ## Examples

      iex> create_local_session(%{field: value})
      {:ok, %LocalSession{}}

      iex> create_local_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_local_session(attrs \\ %{}) do
    %LocalSession{}
    |> LocalSession.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a local_session.

  ## Examples

      iex> update_local_session(local_session, %{field: new_value})
      {:ok, %LocalSession{}}

      iex> update_local_session(local_session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_local_session(%LocalSession{} = local_session, attrs) do
    local_session
    |> LocalSession.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LocalSession.

  ## Examples

      iex> delete_local_session(local_session)
      {:ok, %LocalSession{}}

      iex> delete_local_session(local_session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_local_session(%LocalSession{} = local_session) do
    Repo.delete(local_session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking local_session changes.

  ## Examples

      iex> change_local_session(local_session)
      %Ecto.Changeset{source: %LocalSession{}}

  """
  def change_local_session(%LocalSession{} = local_session) do
    LocalSession.changeset(local_session, %{})
  end
end
