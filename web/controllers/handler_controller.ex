require IEx
defmodule ReventDispatcher.HandlerController do
  use ReventDispatcher.Web, :controller
  
  alias ReventDispatcher.Handler

  def index(conn, _params) do
    handlers = Repo.all(ReventDispatcher.Handler) |> Repo.preload(:events)
    render conn, "index.json", handlers: handlers, events: Repo.all(ReventDispatcher.Event)
  end

  def create(conn, %{"handler" => params}) do
    changeset = Handler.changeset_with_events(%Handler{}, params)

    case Repo.insert(changeset) do
      {:ok, handler} ->
        render conn, "create.json", data: (handler |> Repo.preload(:events))
      {:error, changeset} ->
        conn
        |> put_status(403)
        |> render("errors.json", errors: changeset.errors)
    end
  end

  def update(conn, %{"id" => id, "handler" => params}) do
    handler = Repo.get(Handler, id)
    changeset = Handler.changeset_with_events(handler, params)

    case Repo.update(changeset) do
      {:ok, handler} ->
        render conn, "update.json", data: (handler |> Repo.preload(:events))
      {:error, changeset} ->
        conn
        |> put_status(403)
        |> render("errors.json", errors: changeset.errors)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Repo.delete(Repo.get(Handler, id)) do
      {:ok, handler} -> render conn, "destroy.json", data: (handler |> Repo.preload(:events))
      {:error, changeset} ->
        conn
        |> put_status(404)
        |> render("errors.json", errors: changeset.errors)
    end
  end
end
