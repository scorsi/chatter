defmodule ChatterWeb.MessageController do
    use ChatterWeb, :controller

    plug :action
  
    def index(conn, _params) do
        messages = Chatter.Message.get_msgs()
        render(conn, messages: messages)
    end
  end
  