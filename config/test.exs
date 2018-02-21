use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :calc_bot, CalcBotWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :calc_bot, CalcBot.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "calc_bot_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :argon2_elixir,
  t_cost: 1,
  m_cost: 8
