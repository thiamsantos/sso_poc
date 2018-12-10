defmodule Locker.Repo.Migrations.CreateGlobalSessions do
  use Ecto.Migration

  def change do
    create table(:global_sessions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :revoked_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:global_sessions, [:user_id])
  end
end
