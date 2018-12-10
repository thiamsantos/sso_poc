defmodule Locker.Accounts.Credentials do
  use Ecto.Schema
  import Ecto.Changeset
  
  embedded_schema do
    field :email, :string
    field :password, :string
    field :next_url, :string
  end

  @doc false
  def changeset(login, attrs \\ %{}) do
    login
    |> cast(attrs, [:next_url, :email, :password])
    |> validate_required([:next_url, :email, :password])
  end
end
