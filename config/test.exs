use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :revent_dispatcher, ReventDispatcher.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :revent_dispatcher, amqp_consume: [
  username: "guest",
  password: "guest",
  host: "localhost",
  port: 5672
]

config :revent_dispatcher, amqp_output: [
  username: "guest",
  password: "guest",
  host: "localhost",
  port: 5672
]

# Configure your database
config :revent_dispatcher, ReventDispatcher.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "teachbase",
  password: "teachbase",
  database: "revent_dispatcher_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
