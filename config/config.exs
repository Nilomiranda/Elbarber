# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elbarber,
  ecto_repos: [Elbarber.Repo]

# Configures the endpoint
config :elbarber, ElbarberWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tUCJhZyUv9IKF6cxIr3r/qlKZuBOHhikoQFvX97q//g8fnl4ur5hCOOspSKu4sYq",
  render_errors: [view: ElbarberWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Elbarber.PubSub,
  live_view: [signing_salt: "cQ5on8gR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :phoenix, :filter_parameters, [
  "password",
  "password_hash"
]
