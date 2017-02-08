defmodule ReventDispatcher.EventController do
  use ReventDispatcher.Web, :controller

  def index(conn, _params) do
    render conn, "index.json", events: Repo.all(ReventDispatcher.Event)
  end
end
