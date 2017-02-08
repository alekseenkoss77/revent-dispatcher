defmodule ReventDispatcher.HandlerController do
  use ReventDispatcher.Web, :controller

  def index(conn, _params) do
    handlers = Repo.all(ReventDispatcher.Handler) |> Repo.preload(:events)
    render conn, "index.json", handlers: handlers
  end
end
