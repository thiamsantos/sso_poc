defmodule Locker.Repo.Migrations.CreateLocalSessions do
  use Ecto.Migration

  def change do
    create table(:local_sessions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :revoked_at, :utc_datetime
      add :global_session_id, references(:global_sessions, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :application_id, references(:applications, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:local_sessions, [:global_session_id])
    create index(:local_sessions, [:user_id])
    create index(:local_sessions, [:application_id])
  end
end
