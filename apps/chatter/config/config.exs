use Mix.Config

config :chatter, ecto_repos: [Chatter.Repo]

import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%
config :coherence,
  user_schema: Chatter.Coherence.User,
  repo: Chatter.Repo,
  module: Chatter,
  web_module: ChatterWeb,
  router: ChatterWeb.Router,
  messages_backend: ChatterWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, ChatterWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
