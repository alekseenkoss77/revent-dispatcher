defmodule ReventDispatcher.HandlerController do
  use ReventDispatcher.Web, :controller
  
  alias ReventDispatcher.Handler

  def index(conn, _params) do
    handlers = Repo.all(ReventDispatcher.Handler) |> Repo.preload(:events)
    render conn, "index.json", handlers: handlers
  end

  def create(conn, %{"handler" => params}) do
    changeset = Handler.changeset(%Handler{}, params)

    case Repo.insert(changeset) do
      {:ok, handler} ->
        render conn, "create.json", data: handler
      {:error, changeset} ->
        conn
        |> put_status(403)
        |> render("error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "handler" => params}) do
    handler = Repo.get(Handler, id)
    changeset = Handler.changeset(handler, params)

    case Repo.update(changeset) do
      {:ok, handler} ->
        render conn, "update.json", data: handler
      {:error, changeset} ->
        conn
        |> put_status(403)
        |> render("error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Repo.delete(Repo.get(Handler, id)) do
      {:ok, handler} -> render conn, "destroy.json", data: handler
      {:error, changeset} ->
        conn
        |> put_status(404)
        |> render("errors.json", changeset: changeset)
    end
  end
end
