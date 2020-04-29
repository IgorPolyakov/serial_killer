defmodule Imdb.Hinter do
  def data(query) do
    {:ok, pid} = Postgrex.start_link(hostname: "localhost", username: "postgres", password: "postgres", database: "imdb")
    # Postgrex.query!(pid, "select title, ts_rank(to_tsvector(title), plainto_tsquery('#{query}')) from shows where to_tsvector(title) @@ plainto_tsquery('#{query}') order by ts_rank(to_tsvector(title), plainto_tsquery('#{query}')) DESC LIMIT 10;" , [])
    Postgrex.query!(pid, "SELECT title, id FROM shows WHERE LOWER(title) LIKE LOWER('#{query}%%') LIMIT 10;", [])
    |> Imdb.Hinter.result_to_maps
  end

  def result_to_maps(%Postgrex.Result{columns: _, rows: nil}), do: []

  def result_to_maps(%Postgrex.Result{columns: col_nms, rows: rows}) do
    Enum.map(rows, fn(row) -> row_to_map(col_nms, row) end)
  end

  defp row_to_map(col_nms, vals) do
    Stream.zip(col_nms, vals)
    |> Enum.into(Map.new(), &(&1))
  end
end
