defmodule ChatterWeb.Presence do
  use Phoenix.Presence, otp_app: :chatter,
                        pubsub_server: ChatterWeb.PubSub
end
