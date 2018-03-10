defmodule Chatter.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Chatter.Repo, []),
    ], strategy: :one_for_one, name: Chatter.Supervisor)
  end
end
