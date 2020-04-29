defmodule Imdb.Visualize do
  def data(query) do
    {:ok, pid} = Postgrex.start_link(
      hostname: Application.fetch_env!(:imdb, :hostname),
      username: Application.fetch_env!(:imdb, :username),
      password: Application.fetch_env!(:imdb, :password),
      database: Application.fetch_env!(:imdb, :database)
    )
    data = Postgrex.query!(pid, "SELECT e.id, e.season_number, e.episode_number, r.rating, r.num_votes FROM episodes AS e INNER JOIN ratings AS r ON e.id = r.id WHERE e.show_id = '#{query}' ORDER BY r.rating DESC;" , [])
    GenServer.stop(pid) # https://stackoverflow.com/questions/44702375/how-to-disconnect-postgrex-connection
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
