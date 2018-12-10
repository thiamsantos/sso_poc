# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :locker,
  ecto_repos: [Locker.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :locker, LockerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "reTerkkT/g0PDqCXhFnlO/FAFogbt2HAu5Uc016190ZVQa5+Pq7RBcQ3UU9bwRaB",
  render_errors: [view: LockerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Locker.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
