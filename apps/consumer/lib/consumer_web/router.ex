defmodule ConsumerWeb.Router do
  use ConsumerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ConsumerWeb do
    pipe_through :browser

    get "/user", PageController, :index
    get "/logout", PageController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", ConsumerWeb do
  #   pipe_through :api
  # end
end
