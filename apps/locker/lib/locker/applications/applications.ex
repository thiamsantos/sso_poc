defmodule Locker.Applications do
  @moduledoc """
  The Applications context.
  """

  import Ecto.Query, warn: false
  alias Locker.Repo

  alias Locker.Applications.Application

  @doc """
  Returns the list of applications.

  ## Examples

      iex> list_applications()
      [%Application{}, ...]

  """
  def list_applications do
    Repo.all(Application)
  end

  @doc """
  Gets a single application.

  Raises `Ecto.NoResultsError` if the Application does not exist.

  ## Examples

      iex> get_application!(123)
      %Application{}

      iex> get_application!(456)
      ** (Ecto.NoResultsError)

  """
  def get_application!(id), do: Repo.get!(Application, id)

  @doc """
  Creates a application.

  ## Examples

      iex> create_application(%{field: value})
      {:ok, %Application{}}

      iex> create_application(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_application(attrs \\ %{}) do
    %Application{}
    |> Application.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a application.

  ## Examples

      iex> update_application(application, %{field: new_value})
      {:ok, %Application{}}

      iex> update_application(application, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_application(%Application{} = application, attrs) do
    application
    |> Application.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Application.

  ## Examples

      iex> delete_application(application)
      {:ok, %Application{}}

      iex> delete_application(application)
      {:error, %Ecto.Changeset{}}

  """
  def delete_application(%Application{} = application) do
    Repo.delete(application)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking application changes.

  ## Examples

      iex> change_application(application)
      %Ecto.Changeset{source: %Application{}}

  """
  def change_application(%Application{} = application) do
    Application.changeset(application, %{})
  end

  alias Locker.Applications.UserApplication

  @doc """
  Returns the list of user_applications.

  ## Examples

      iex> list_user_applications()
      [%UserApplication{}, ...]

  """
  def list_user_applications do
    Repo.all(UserApplication)
  end

  @doc """
  Gets a single user_applications.

  Raises `Ecto.NoResultsError` if the User applications does not exist.

  ## Examples

      iex> get_user_applications!(123)
      %UserApplication{}

      iex> get_user_applications!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_applications!(id), do: Repo.get!(UserApplication, id)

  @doc """
  Creates a user_applications.

  ## Examples

      iex> create_user_applications(%{field: value})
      {:ok, %UserApplication{}}

      iex> create_user_applications(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_applications(attrs \\ %{}) do
    %UserApplication{}
    |> UserApplication.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_applications.

  ## Examples

      iex> update_user_applications(user_applications, %{field: new_value})
      {:ok, %UserApplication{}}

      iex> update_user_applications(user_applications, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_applications(%UserApplication{} = user_applications, attrs) do
    user_applications
    |> UserApplication.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserApplication.

  ## Examples

      iex> delete_user_applications(user_applications)
      {:ok, %UserApplication{}}

      iex> delete_user_applications(user_applications)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_applications(%UserApplication{} = user_applications) do
    Repo.delete(user_applications)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_applications changes.

  ## Examples

      iex> change_user_applications(user_applications)
      %Ecto.Changeset{source: %UserApplication{}}

  """
  def change_user_applications(%UserApplication{} = user_applications) do
    UserApplication.changeset(user_applications, %{})
  end
end
