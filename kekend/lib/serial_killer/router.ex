defmodule SerialKiller.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "hinter" do
    query = conn.params["query"]
    result = SerialKiller.Hinter.data(query)

    send_json(conn, result)
  end

  get "visualize" do
    show_id = conn.params["show_id"]
    result = SerialKiller.Visualize.data(show_id)

    send_json(conn, result)
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  defp send_json(conn, map) do
    conn
    |> put_resp_content_type("application/json")
    |> put_resp_header("access-control-allow-origin", "*")
    |> put_resp_header("access-control-allow-methods", "OPTIONS, GET")
    |> send_resp(200, Jason.encode!(map))
  end
end
