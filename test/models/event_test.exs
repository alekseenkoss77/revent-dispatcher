defmodule ReventDispatcher.EventTest do
  use ReventDispatcher.ModelCase

  alias ReventDispatcher.Event
  alias ReventDispatcher.Handler
  alias ReventDispatcher.Repo

  @valid_attrs %{name: "account.create"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end

  test ".find_by_name(name) function" do
    event = Repo.insert!(Event.changeset(%Event{}, %{name: "account.create"})) |> Repo.preload(:handlers)
    handlers = ["email_worker", "sms_worker", "log_worker"]
    
    Enum.each(handlers, 
      fn(h) -> 
        Repo.insert!(Handler.changeset(%Handler{}, %{queue_name: h}) |> Ecto.Changeset.put_assoc(:events, [event]))    
      end)

    assert Enum.map(Event.find_by_name("account.create").handlers(), fn(h) -> h.queue_name end) == handlers
  end
end
