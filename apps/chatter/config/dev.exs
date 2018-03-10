use Mix.Config

# Configure your database
config :chatter, Chatter.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "chatter_dev",
  hostname: "localhost",
  pool_size: 10
