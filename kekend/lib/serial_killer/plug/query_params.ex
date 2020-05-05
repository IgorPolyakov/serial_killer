defmodule SerialKiller.Plug.QueryParams do
  @moduledoc """
  A Plug to fetch query params
  """

  @behaviour Plug

  def init([]), do: []

  def call(conn, []) do
    params =
      conn
      |> Plug.Conn.fetch_query_params()
      |> Map.get(:params)

    %{conn | params: params}
  end
end
