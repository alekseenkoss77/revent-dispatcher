defmodule ReventDispatcher.EventController do
  use ReventDispatcher.Web, :controller

  alias ReventDispatcher.Event

  def index(conn, _params) do
    render conn, "index.json", events: Repo.all(Event)
  end

  def create(conn, %{"event" => params}) do
    changeset = Event.changeset(%Event{}, params)

    case Repo.insert(changeset) do
      {:ok, event} ->
        render conn, "create.json", data: event
      {:error, changeset} ->
        conn
        |> put_status(403)
        |> render("errors.json", errors: changeset.errors)
    end
  end

  def update(conn, %{"id" => id, "event" => params}) do
    event = Repo.get(Event, id)
    changeset = Event.changeset(event, params)

    case Repo.update(changeset) do
      {:ok, event} ->
        render conn, "update.json", data: event
      {:error, changeset} ->
        conn
        |> put_status(403)
        |> render("errors.json", errors: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Repo.delete(Repo.get(Event, id)) do
      {:ok, event} -> render conn, "destroy.json", data: event
      {:error, changeset} ->
        conn
        |> put_status(404)
        |> render("errors.json", changeset: changeset)
    end
  end
end
