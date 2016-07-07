defmodule Codecasts.Mixfile do
  use Mix.Project

  def project do
    [app: :codecasts,
     version: "0.0.1",
     elixir: ">= 1.2.6",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Codecasts, []},
     applications: [
      :phoenix,
      :phoenix_pubsub,
      :phoenix_html,
      :cowboy,
      :logger,
      :gettext,
      :phoenix_ecto,
      :postgrex,
      :comeonin,
      :guardian,
      :ueberauth,
      :ueberauth_google,
      :ex_aws,
      :httpoison
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.2.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.6"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:comeonin, "~> 2.0"},

      # Auth
      {:guardian, "~> 0.12.0"},
      {:ueberauth, "~> 0.2"},
      {:ueberauth_google, "~> 0.2"},

      # Authorization
      {:canada, "~> 1.0.0"},

      # Enums
      {:ecto_enum, "~> 0.3.0"},
      # DateTime funcs
      {:calecto, "~> 0.16.0"},

      # File uploads
      {:arc, "~> 0.5.2"},
      {:arc_ecto, "~> 0.4.2"},
      {:ex_aws, "~> 0.4.10"}, # Required if using Amazon S3
      {:httpoison, "~> 0.7"},  # Required if using Amazon S3
      {:poison, "~> 1.2"}     # Required if using Amazon S3
   ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
