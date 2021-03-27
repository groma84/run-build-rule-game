# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :server,
  ecto_repos: [Server.Repo]

# Configures the endpoint
config :server, ServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RviymX1FSzp3SNFJIwj01CkX1KqBUzBtdYDyZdbjDD+db0i5aWaXPDvB7AMDto/1",
  render_errors: [view: ServerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Server.PubSub,
  live_view: [signing_salt: "up6hE9lt"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "https://www.googleapis.com/auth/fitness.activity.read"]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
