defmodule SerialKiller.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "hinter" do
    query = conn.params["query"]
    hints = SerialKiller.Hinter.get_hints(query)

    send_json(conn, hints)
  end

  get "visualize" do
    show_id = conn.params["show_id"]
    ratings = SerialKiller.Visualize.get_ratings(show_id)

    send_json(conn, ratings)
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
