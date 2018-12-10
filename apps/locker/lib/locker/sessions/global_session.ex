defmodule Locker.Sessions.GlobalSession do
  use Ecto.Schema
  import Ecto.Changeset
  alias Locker.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "global_sessions" do
    field :revoked_at, :utc_datetime
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(global_session, attrs) do
    global_session
    |> cast(attrs, [:user_id, :revoked_at])
    |> validate_required([:user_id])
  end
end
