# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :codecasts,
  ecto_repos: [Codecasts.Repo]

# Configures the endpoint
config :codecasts, Codecasts.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2rqbfrRBFzfvPMPr3dIvQ49ajCojOtu5SRqitYBizQJGbUnM3k2tp28paUUoiJqf",
  render_errors: [view: Codecasts.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Codecasts.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Codecasts.#{Mix.env}",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: to_string(Mix.env),
  serializer: Codecasts.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
