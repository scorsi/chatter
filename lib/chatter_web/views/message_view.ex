defmodule ChatterWeb.MessageView do
    use ChatterWeb, :view
  
    def render("index.json", %{messages: messages}) do
      messages
    end
  end