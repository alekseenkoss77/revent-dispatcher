defmodule ReventDispatcher.HandlerControllerTest do
  use ReventDispatcher.ConnCase
  import ReventDispatcher.Factory

  alias ReventDispatcher.Handler

  @username Application.get_env(:revent_dispatcher, :basic_auth)[:username]
  @password Application.get_env(:revent_dispatcher, :basic_auth)[:password]

  defp using_basic_auth(conn, username, password) do
    header_content = "Basic " <> Base.encode64("#{username}:#{password}")
    conn |> put_req_header("authorization", header_content)
         |> put_req_header("content-type", "application/json")
  end

  test "GET /handlers" do
    insert(:handler, name: "hooker")
    insert(:handler, name: "mailer")

    response = build_conn()
              |> using_basic_auth(@username, @password)
              |> get(handler_path(build_conn(), :index))
              |> json_response(200)

    assert length(response["handlers"]) == 2
  end

  test "POST /handlers/create creates new handler with assoc" do
    ev = insert(:event)
    params = %{ "handler" => params_for(:handler, events: [ev.id], name: "mailer") }
    response = build_conn()
              |> post(handler_path(build_conn(), :create), params)
              |> json_response(200)
    
    assert response["name"] == "mailer"
  end

  test "POST /handlers validates when creating" do
    params = %{ "handler" => params_for(:handler, queue_name: nil, events: []) }
    response = build_conn()
              |> post(handler_path(build_conn(), :create), params)
              |> json_response(403)
    
    assert %{ "errors" => ["queue_name can't be blank"] } == response
  end

  test "PUT /handlers updates" do
    handler = insert(:handler, name: "mailer")
    params = %{ "handler" => params_for(:handler, name: "hooker") }
    build_conn()
      |> put(handler_path(build_conn(), :update, handler.id), params)
      |> json_response(200)

    assert Repo.get(Handler, handler.id).name == "hooker"
  end

  test "PUT /handlers attach event assoc" do
    ev = insert(:event, name: "Email")
    handler = insert(:handler, name: "mailer")
    params = %{ "handler" => params_for(:handler, events: [ev.id]) }
    build_conn()
      |> put(handler_path(build_conn(), :update, handler.id), params)
      |> json_response(200)

    [event | _] = (handler |> Repo.preload(:events)).events

    assert event.id == ev.id
  end

  test "DELETE /handlers deletes record" do
    h = insert(:handler)
    build_conn()
      |> delete(handler_path(build_conn(), :delete, h.id))
      |> json_response(200)

    assert Repo.get(Handler, h.id) == nil
  end
end
