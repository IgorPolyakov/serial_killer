defmodule SerialKiller.Searcher do
  alias SerialKiller.DB

  # TODO: make it configurable via query string
  @limit 100

  def search(search_query) do
    DB.query!(
      "SELECT *
       FROM shows
       WHERE title_to_tsvector(title) @@ plainto_tsquery('simple', unaccent($1))
       LIMIT #{@limit}",
      # TODO: order by num_votes
      [search_query]
    )
  end
end
