defmodule LockerWeb.Router do
  use LockerWeb, :router

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

  scope "/", LockerWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/login", LoginController
    resources "/users", UserController
    resources "/global_sessions", GlobalSessionController
    resources "/local_sessions", LocalSessionController
    resources "/applications", ApplicationController
    resources "/user_applications", UserApplicationController
    
    get "/session/logout", API.SessionController, :logout
  end

  scope "/api" do
    pipe_through :api

    post "/session/validate", LockerWeb.API.SessionController, :validate
  end
end
