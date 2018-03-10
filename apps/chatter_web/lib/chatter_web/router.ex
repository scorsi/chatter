defmodule ChatterWeb.Router do
  use ChatterWeb, :router
  use Coherence.Router


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    Coherence.Router.coherence_routes
  end
  
  scope "/" do
    pipe_through :protected

    Coherence.Router.coherence_routes :protected
  end
  
  scope "/", ChatterWeb do
    pipe_through :browser
    
  end
  
  scope "/", ChatterWeb do
    pipe_through :protected

    get "/", PageController, :index
  end

  defp put_user_token(conn, _) do
    current_user = Coherence.current_user(conn).id
    user_id_token = Phoenix.Token.sign(conn, "user_id", current_user)
    conn
    |> assign(:user_id, user_id_token)
  end
end
