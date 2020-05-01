defmodule SerialKiller.Visualize do
  def get_ratings(show_id) do
    Postgrex.query!(
      SerialKiller.DB,
      "SELECT e.id, e.season_number, e.episode_number, r.rating, r.num_votes FROM episodes AS e INNER JOIN ratings AS r ON e.id = r.id WHERE e.show_id = $1 ORDER BY r.rating DESC",
      [show_id]
    )
    |> result_to_maps
  end

  def result_to_maps(%Postgrex.Result{columns: _, rows: nil}), do: []

  # FIXME: move it to helpers?
  def result_to_maps(%Postgrex.Result{columns: col_nms, rows: rows}) do
    Enum.map(rows, fn(row) -> row_to_map(col_nms, row) end)
  end

  defp row_to_map(col_nms, vals) do
    Stream.zip(col_nms, vals)
    |> Enum.into(Map.new(), &(&1))
  end
end
