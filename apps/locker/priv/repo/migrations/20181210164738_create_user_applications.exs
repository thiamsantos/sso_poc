defmodule Locker.Repo.Migrations.CreateUserApplication do
  use Ecto.Migration

  def change do
    create table(:user_applications, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :application_id, references(:applications, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:user_applications, [:user_id])
    create index(:user_applications, [:application_id])
  end
end
