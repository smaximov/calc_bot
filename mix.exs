defmodule CalcBot.Mixfile do
  use Mix.Project

  def project do
    [
      app: :calc_bot,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: [plt_add_deps: :transitive]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {CalcBot.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:distillery, "~> 1.5.2"},
      {:libcluster, "~> 2.3.0"},
      {:jason, "~> 1.0.0"},
      {:hashids, "~> 2.0.4"},

      # GraphQL
      {:absinthe_plug, "~> 1.4.2"},
      {:apollo_tracing, "~> 0.4.1"},

      # Passwords
      {:comeonin, "~> 4.1.0"},
      {:argon2_elixir, "~> 1.2.14"},
      {:not_qwerty123, "~> 2.3.0"},

      # Dev and test dependencies
      {:ex_doc, "~> 0.18.3", only: [:dev], runtime: false},
      {:ex_machina, "~> 2.1.0", only: :test},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.6.8", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.9.0-rc6", only: [:dev, :test], runtime: false},
      {:junit_formatter, "~> 2.2", only: [:test]}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
