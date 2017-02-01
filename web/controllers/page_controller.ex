defmodule ReventDispatcher.PageController do
  use ReventDispatcher.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
