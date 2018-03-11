defmodule ChatterWeb do
  
  def controller do
    quote do
      use Phoenix.Controller, namespace: ChatterWeb
      import Plug.Conn
      import ChatterWeb.Router.Helpers
      import ChatterWeb.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/chatter_web/templates",
                        namespace: ChatterWeb

      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      import ChatterWeb.Router.Helpers
      import ChatterWeb.ErrorHelpers
      import ChatterWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import ChatterWeb.Gettext
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
