defmodule ReventDispatcher.EventController do
  use ReventDispatcher.Web, :controller

  alias ReventDispatcher.Event

  def index(conn, _params) do
    render conn, "index.json", events: Repo.all(Event)
  end

  def create(conn, %{"event" => params}) do
    changeset = Event.changeset(%Event{}, params)
    IO.inspect(params)
    case Repo.insert(changeset) do
      {:ok, event} ->
        render conn, "create.json", data: event
      {:error, changeset} ->
        conn
        |> put_status(403)
        |> render("error.json", changeset: changeset)
    end
  end
end
