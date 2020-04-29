defmodule Imdb.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"

  get "hinter" do
    conn
    |> put_resp_content_type(@content_type)
    |> send_resp(200, hinter(conn.params["query"]))
  end

  get "visualize" do
    conn
    |> put_resp_content_type(@content_type)
    |> send_resp(200, visualize(conn.params["show_id"]))
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  defp hinter(query) do
    Jason.encode!(
      Imdb.Hinter.data(query)
    )
  end

  defp visualize(id) do
    Jason.encode!(
      Imdb.Visualize.data(id)
    )
  end
end
