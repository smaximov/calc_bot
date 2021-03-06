# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :calc_bot, ecto_repos: [CalcBot.Repo]

# Configures the endpoint
config :calc_bot, CalcBotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IBms8baesPK6inLQZ7cy6in1jQCtMjfg/EeyYEP5VPbT7wGToRQErnE7Y32pe3W6",
  render_errors: [view: CalcBotWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: CalcBot.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ecto, json_library: Jason

config :calc_bot, CalcBot.Repo, types: CalcBot.PostgresTypes

config :phoenix, :format_encoders, json_encoders: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
