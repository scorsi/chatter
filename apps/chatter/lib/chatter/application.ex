defmodule Chatter.Application do
  @moduledoc """
  The Chatter Application Service.

  The chatter system business domain lives in this application.

  Exposes API to clients such as the `ChatterWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Chatter.Repo, []),
    ], strategy: :one_for_one, name: Chatter.Supervisor)
  end
end
