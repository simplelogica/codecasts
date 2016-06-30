defmodule Codecasts.Router do
  use Codecasts.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/", Codecasts do
    pipe_through [:browser, :browser_session] # Use the default browser stack

    resources "/users", UserController

    get "/", PageController, :index
  end

  scope "/sessions", Codecasts do
    pipe_through [:browser, :browser_session] # Use the default browser stack

    get "/new", SessionController, :new
    get "/:provider", SessionController, :request
    get "/:provider/callback", SessionController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Codecasts do
  #   pipe_through :api
  # end
end
