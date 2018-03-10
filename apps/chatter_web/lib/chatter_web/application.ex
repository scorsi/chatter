defmodule ChatterWeb.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(ChatterWeb.Endpoint, []),
      supervisor(ChatterWeb.Presence, []),
    ]

    opts = [strategy: :one_for_one, name: ChatterWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ChatterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
