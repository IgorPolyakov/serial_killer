defmodule SerialKiller.Popular do
  alias SerialKiller.DB

  # TODO: maybe make it configurable via query params
  @limit 100

  # TODO: cache results
  def get_popular_shows do
    DB.query!(
      "SELECT *
       FROM shows
       ORDER BY num_votes DESC
       LIMIT #{@limit}",
      []
    )
  end
end
