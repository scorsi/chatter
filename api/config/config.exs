use Mix.Config

config :chatter,
  ecto_repos: [Chatter.Repo]

config :chatter, ChatterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+pkQCg2GenhwEWwfpTrMtZF/Qt2XiFxKZ+9b0anWqONkFd4dngUqYZN3bxVyqBef",
  render_errors: [view: ChatterWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Chatter.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

import_config "#{Mix.env}.exs"
