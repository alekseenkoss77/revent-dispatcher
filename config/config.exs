# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :revent_dispatcher, ReventDispatcher.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "revent_dispatcher_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"


# General application configuration
config :revent_dispatcher,
  ecto_repos: [ReventDispatcher.Repo]

# Configures the endpoint
config :revent_dispatcher, ReventDispatcher.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vDsVPImkPfx0XfBZPtsCzovdeh4DbRJNFn5kT1P1AGiFa05BnIEM0Pe7+aVkZf4a",
  render_errors: [view: ReventDispatcher.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ReventDispatcher.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
