defmodule ChatterWeb.ErrorHelpers do
  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(ChatterWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(ChatterWeb.Gettext, "errors", msg, opts)
    end
  end
end
