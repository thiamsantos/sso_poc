defmodule Locker.Repo do
  use Ecto.Repo,
    otp_app: :locker,
    adapter: Ecto.Adapters.Postgres
end
