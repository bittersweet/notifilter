use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :notifilter, Notifilter.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger,
  backends: [:console],
  compile_time_purge_level: :debug,
  level: :warn

# Configure your database
config :notifilter, Notifilter.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "markmulder",
  password: "markmulder",
  database: "notifilter_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
