defmodule ElbarberWeb.Router do
  use ElbarberWeb, :router

#  pipeline :browser do
#    plug :accepts, ["html"]
#    plug :fetch_session
#    plug :fetch_flash
#    plug :protect_from_forgery
#    plug :put_secure_browser_headers
#  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :session do
    plug :fetch_session
    plug Plug.Session, store: :cookie, key: "elbarber_session", table: :session, signing_salt: "elbarber_salt_test", key_length: 64
  end

  scope "/", ElbarberWeb do
    pipe_through :api

    get "/", PageController, :index
  end

  scope "/users", ElbarberWeb do
    pipe_through :api
    pipe_through :session

    get "/all", UserController, :index
    post "/", UserController, :create
  end

  scope "/sessions", ElbarberWeb do
    pipe_through :api
    pipe_through :session

    post "/", SessionController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElbarberWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
#  if Mix.env() in [:dev, :test] do
#    import Phoenix.LiveDashboard.Router
#
#    scope "/" do
#      pipe_through :browser
#      live_dashboard "/dashboard", metrics: ElbarberWeb.Telemetry
#    end
#  end
end
