defmodule Mango.Mixfile do
  use Mix.Project

  def project do
    [
      app: :mango,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Mango.Application, []},
      extra_applications: [:logger, :runtime_tools, :httpoison, :bamboo, :bamboo_smtp]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.2"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:hound, "~> 1.0"},
      {:nimble_csv, "~> 0.1.0"},
      {:comeonin, "~> 4.0"},
      {:bcrypt_elixir, "~> 0.12.0"},
      {:httpoison, "~> 1.0"},
      {:blankable, "~> 0.0.1"},
      {:bamboo, "~> 0.8"},
      {:bamboo_smtp, "~> 1.4.0"}
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
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
      "phantomjs": ["cmd phantomjs --wd"],
      "seed": ["run priv/repo/seeds.exs"],
      "server.s": ["cmd iex -S mix phx.server"],
      "server.db": ["cmd postgres -D /usr/local/var/postgres"]
    ]
  end
end
