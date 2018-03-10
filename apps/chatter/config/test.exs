use Mix.Config

config :chatter, Chatter.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "chatter_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
