defmodule ReventDispatcher.EventControllerTest do
  use ReventDispatcher.ConnCase
  import ReventDispatcher.Factory

  alias ReventDispatcher.Event

  @username Application.get_env(:revent_dispatcher, :basic_auth)[:username]
  @password Application.get_env(:revent_dispatcher, :basic_auth)[:password]

  defp using_basic_auth(conn, username, password) do
    header_content = "Basic " <> Base.encode64("#{username}:#{password}")
    conn |> put_req_header("authorization", header_content)
         |> put_req_header("content-type", "application/json")
  end

  test "GET /events" do
    insert(:event, name: "webhook")
    insert(:event, name: "email")

    response = build_conn()
              |> using_basic_auth(@username, @password)
              |> get(event_path(build_conn(), :index))
              |> json_response(200)

    assert length(response["events"]) == 2
  end

  test "POST /events/create creates new event" do
    params = %{ "event" => params_for(:event, name: "webhook") }
    response = build_conn()
              |> post(event_path(build_conn(), :create), params)
              |> json_response(200)
    
    assert response["name"] == "webhook"
  end

  test "POST /events/create validates uniq names" do
    insert(:event, name: "webhook")
    params = %{ "event" => params_for(:event, name: "webhook") }
    response = build_conn()
              |> post(event_path(build_conn(), :create), params)
              |> json_response(403)
    
    assert %{ "errors" => ["name has already been taken"] } == response
  end

  test "PUT /events updates event" do
    ev = insert(:event, name: "webhook")
    params = %{ "event" => params_for(:event, name: "email") }

    build_conn()
      |> put(event_path(build_conn(), :update, ev.id), params)
      |> json_response(200)

    assert Repo.get(Event, ev.id).name == "email"
  end

  test "DELETE /events deletes event" do
    ev = insert(:event)
    build_conn()
      |> delete(event_path(build_conn(), :delete, ev.id))
      |> json_response(200)

    assert Repo.get(Event, ev.id) == nil
  end
end
