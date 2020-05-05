defmodule SerialKiller.Searcher do
  alias SerialKiller.DB

  def search(query) do
    DB.query!(
      "SELECT $1::text AS ok",
      [query]
    )
  end
end
