defmodule SerialKiller.Router do
  alias SerialKiller.Show

  use Plug.Router
  use Plug.Debugger
  use Plug.ErrorHandler

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(SerialKiller.Plug.QueryParams)
  plug(:dispatch)

  get "/hinter" do
    letters = conn.params["letters"]
    hints = Show.get_hints(letters)

    send_json(conn, hints)
  end

  get "/visualizer" do
    show_id = conn.params["show_id"]
    show_with_episodes = Show.get_show_with_episodes(show_id)

    send_json(conn, show_with_episodes)
  end

  get "/searcher" do
    words = conn.params["words"]
    shows = Show.search_shows(words)

    send_json(conn, shows)
  end

  get "/best" do
    best_shows = Show.get_best_shows()

    send_json(conn, best_shows)
  end

  get "/popular" do
    popular_shows = Show.get_popular_shows()

    send_json(conn, popular_shows)
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  ##############################################################################
  ## Private
  ##############################################################################

  defp send_json(conn, map) do
    conn
    |> put_resp_content_type("application/json")
    |> put_resp_header("access-control-allow-origin", "*")
    |> put_resp_header("access-control-allow-methods", "OPTIONS, GET")
    |> send_resp(200, Jason.encode!(map))
  end
end
