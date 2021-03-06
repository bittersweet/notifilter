use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :notifilter, Notifilter.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false,
  watchers: [npm: ["start", cd: Path.expand("../", __DIR__)]]

# Watch static and templates for browser reloading.
config :notifilter, Notifilter.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :notifilter, Notifilter.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("NOTIFILTER_DBUSER"),
  password: System.get_env("NOTIFILTER_DBPASSWORD"),
  database: System.get_env("NOTIFILTER_DBNAME"),
  hostname: System.get_env("NOTIFILTER_DBHOSTNAME"),
  pool_size: 10

config :notifilter, Google,
  client_id: System.get_env("NOTIFILTER_GOOGLECLIENTID"),
  client_secret: System.get_env("NOTIFILTER_GOOGLECLIENTSECRET"),
  redirect_uri: System.get_env("NOTIFILTER_REDIRECTURI")

config :notifilter, Elasticsearch, host: System.get_env("NOTIFILTER_ESHOST")

config :notifilter, Receive, hostname: System.get_env("NOTIFILTER_RECEIVE_HOSTNAME")

config :notifilter, ApiKey, key: System.get_env("NOTIFILTER_API_KEY")
