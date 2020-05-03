defmodule SerialKiller.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "hinter" do
    query = conn.params["q"]
    hints = SerialKiller.Hinter.get_hints(query)

    send_json(conn, hints)
  end

  get "visualizer" do
    show_id = conn.params["show_id"]
    show_with_episodes = SerialKiller.Visualizer.get_show_with_episodes(show_id)

    send_json(conn, show_with_episodes)
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
