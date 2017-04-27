# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ReventDispatcher.Repo.insert!(%ReventDispatcher.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ReventDispatcher.Repo
alias ReventDispatcher.Event
alias ReventDispatcher.Handler

handler_params = %{
  name: "Logger",
  queue_name: "logger_queue",
  events: [
    %{name: "account.create"},
    %{name: "account.update"},
    %{name: "user.attach.account"}
  ]
}

handler = Repo.insert!(Handler.changeset(%Handler{}, handler_params))

