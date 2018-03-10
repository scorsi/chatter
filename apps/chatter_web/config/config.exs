
use Mix.Config

config :chatter_web,
  namespace: ChatterWeb,
  ecto_repos: [Chatter.Repo]

config :chatter_web, ChatterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oGClCkelbiwPV+V5xDEgY8aHbRxofgwe+pzcQSJtpfIx5UI8w4JI7LezZ8uM7/bw",
  render_errors: [view: ChatterWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ChatterWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :chatter_web, :generators,
  context_app: :chatter

import_config "#{Mix.env}.exs"
