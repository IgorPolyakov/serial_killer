defmodule Imdb.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"

  get "/" do
    conn
    |> put_resp_content_type(@content_type)
    |> send_resp(200, message(conn.params["query"]))
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  defp message(query) do
    Jason.encode!(
      Imdb.Hinter.data(query)
    )
  end
end
