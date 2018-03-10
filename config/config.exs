
use Mix.Config

config :chatter,
  ecto_repos: [Chatter.Repo]

config :chatter, ChatterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qxEmh2ROpiGtWrA771uhMZle08l/DAnZ787iIi7mmcRO5+hkDkPPE1GyXX77oXFa",
  render_errors: [view: ChatterWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chatter.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

import_config "#{Mix.env}.exs"
