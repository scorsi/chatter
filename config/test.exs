use Mix.Config

config :chatter, ChatterWeb.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn

config :chatter, Chatter.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "chatter_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
