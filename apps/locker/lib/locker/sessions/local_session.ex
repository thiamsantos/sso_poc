defmodule Locker.Sessions.LocalSession do
  use Ecto.Schema
  import Ecto.Changeset
  alias Locker.Sessions.GlobalSession
  alias Locker.Accounts.User
  alias Locker.Applications.Application

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "local_sessions" do
    field :revoked_at, :utc_datetime
    belongs_to :global_session, GlobalSession
    belongs_to :user, User
    belongs_to :application, Application

    timestamps()
  end

  @required_fields [:global_session_id, :user_id, :application_id]
  @optional_fields [:revoked_at]

  @doc false
  def changeset(local_session, attrs) do
    local_session
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
