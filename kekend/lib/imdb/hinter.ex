defmodule Imdb.Hinter do
  def data(query) do
    {:ok, pid} = Postgrex.start_link(
      hostname: Application.fetch_env!(:imdb, :hostname),
      username: Application.fetch_env!(:imdb, :username),
      password: Application.fetch_env!(:imdb, :password),
      database: Application.fetch_env!(:imdb, :database)
    )
    # Postgrex.query!(pid, "select title, ts_rank(to_tsvector(title), plainto_tsquery('#{query}')) from shows where to_tsvector(title) @@ plainto_tsquery('#{query}') order by ts_rank(to_tsvector(title), plainto_tsquery('#{query}')) DESC LIMIT 10;" , [])
    data = Postgrex.query!(pid, "SELECT title, id FROM shows WHERE LOWER(title) LIKE LOWER('#{query}%%') LIMIT 10;", [])
    GenServer.stop(pid)
    Imdb.Hinter.result_to_maps(data)
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
