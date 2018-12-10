defmodule Locker.Applications.UserApplication do
  use Ecto.Schema
  import Ecto.Changeset
  alias Locker.Accounts.User
  alias Locker.Applications.Application

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_applications" do
    belongs_to :user, User
    belongs_to :application, Application

    timestamps()
  end

  @doc false
  def changeset(user_applications, attrs) do
    user_applications
    |> cast(attrs, [:user_id, :application_id])
    |> validate_required([:user_id, :application_id])
  end
end
