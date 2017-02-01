defmodule ReventDispatcher.EventTest do
  use ReventDispatcher.ModelCase

  alias ReventDispatcher.Event

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
end