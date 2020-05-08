defmodule SerialKiller.Router do
  use Plug.Router
  use Plug.Debugger
  use Plug.ErrorHandler

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(SerialKiller.Plug.QueryParams)
  plug(:dispatch)

  get "/hinter" do
    letters = conn.params["letters"]
    hints = SerialKiller.Hinter.get_hints(letters)

    send_json(conn, hints)
  end

  get "/visualizer" do
    show_id = conn.params["show_id"]
    show_with_episodes = SerialKiller.Visualizer.get_show_with_episodes(show_id)

    send_json(conn, show_with_episodes)
  end

  get "/searcher" do
    words = conn.params["words"]
    shows = SerialKiller.Searcher.search_shows(words)

    send_json(conn, shows)
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
