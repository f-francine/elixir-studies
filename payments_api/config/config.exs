# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :payments_api,
  ecto_repos: [PaymentsApi.Repo]

config :payments_api, PaymentsApi.Repo,
  database: "payments_api_repo",
  username: "user",
  password: "user",
  hostname: "localhost"

# Configures the endpoint
config :payments_api, PaymentsApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "I9bCtSu3Bd4iO743ZobxpIme2KcbtcNCgCisao3HcntGU8ahoQ1NMWRC8jEooEnM",
  render_errors: [view: PaymentsApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PaymentsApi.PubSub,
  live_view: [signing_salt: "raLRBWC6"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
