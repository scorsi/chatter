defmodule ChatterWeb.Router do
  use ChatterWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    # plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    # plug Guardian.Plug.LoadResource
  end

  pipeline :graphql do
    plug ChatterWeb.Context
  end

  scope "/", ChatterWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
  end

  scope "/api" do
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: ChatterWeb.Schema
  end

  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: ChatterWeb.Schema
end
