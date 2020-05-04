defmodule SerialKiller.DB do
  @doc """
  Our custom wrapper around Postgrex.query!/4
  https://hexdocs.pm/postgrex/Postgrex.html#query!/4
  """
  def query!(statement, params, opts \\ []) do
    Postgrex.query!(
      __MODULE__,
      statement,
      params,
      opts
    )
    |> result_to_maps()
  end

  defp result_to_maps(%Postgrex.Result{num_rows: 0}), do: []

  defp result_to_maps(%Postgrex.Result{columns: columns, rows: rows}) do
    Enum.map(rows, &row_to_map(columns, &1))
  end

  defp row_to_map(columns, row_values) do
    Stream.zip(columns, row_values) |> Enum.into(%{})
  end
end
