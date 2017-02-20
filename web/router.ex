defmodule ReventDispatcher.Router do
  use ReventDispatcher.Web, :router

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

  scope "/api", ReventDispatcher do
    pipe_through :api

    resources "/events", EventController
    resources "/handlers", HandlerController
  end

  scope "/", ReventDispatcher do
    pipe_through :browser

    get "/*page", PageController, :index
  end
end
