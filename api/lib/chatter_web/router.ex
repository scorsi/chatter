defmodule ChatterWeb.Router do
  use ChatterWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChatterWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
  end

  forward "/api", Absinthe.Plug, schema: ChatterWeb.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: ChatterWeb.Schema
end
