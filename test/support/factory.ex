defmodule ReventDispatcher.Factory do
  use ExMachina.Ecto, repo: ReventDispatcher.Repo

  def event_factory do
    %ReventDispatcher.Event{
      name: sequence("Event")
    }
  end

  def handler_factory do
    %ReventDispatcher.Handler{
      name: sequence("Handler"),
      queue_name: sequence("Queue")
    }
  end
end
