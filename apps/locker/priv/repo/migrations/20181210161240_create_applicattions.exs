defmodule Locker.Repo.Migrations.CreateApplicattions do
  use Ecto.Migration

  def change do
    create table(:applications, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :domain, :string

      timestamps()
    end
  end
end
