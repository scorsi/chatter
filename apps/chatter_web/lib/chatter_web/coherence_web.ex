defmodule ChatterWeb.Coherence do
  def view do
    quote do
      use Phoenix.View, root: "../chatter_web/lib/chatter_web/templates"

      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      use Phoenix.HTML

      import ChatterWeb.Router.Helpers
      import ChatterWeb.ErrorHelpers
      import ChatterWeb.Gettext
      import ChatterWeb.Coherence.ViewHelpers
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, except: [layout_view: 2]
      use Coherence.Config
      use Timex

      import Ecto
      import Ecto.Query
      import Plug.Conn
      import ChatterWeb.Router.Helpers
      import ChatterWeb.Gettext
      import Coherence.ControllerHelpers

      alias Coherence.Config
      alias Coherence.ControllerHelpers, as: Helpers

      require Redirects
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
