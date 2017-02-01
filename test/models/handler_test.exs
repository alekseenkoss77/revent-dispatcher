defmodule ReventDispatcher.HandlerTest do
  use ReventDispatcher.ModelCase

  alias ReventDispatcher.Handler
  alias ReventDispatcher.Event

  @valid_attrs %{name: "Email worker", queue_name: "email_worker"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Handler.changeset(%Handler{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Handler.changeset(%Handler{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "build association" do
    event = Repo.insert!(Event.changeset(%Event{}, %{name: "account.create"})) |> Repo.preload(:handlers)
    handler = Repo.insert!(Handler.changeset(%Handler{}, %{queue_name: "email_worker"}) |> Ecto.Changeset.put_assoc(:events, [event]))
    
    [rel | _] = handler.events
    assert rel == event
  end
end
