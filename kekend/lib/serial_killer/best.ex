defmodule SerialKiller.Best do
  alias SerialKiller.DB

  # TODO: maybe make it configurable via query params
  @limit 100

  # TODO: think how to calculte best shows
  @min_num_votes_to_consider_show_good 100_000

  # TODO: cache results
  def get_best_shows do
    DB.query!(
      "SELECT *
       FROM shows
       WHERE num_votes >= #{@min_num_votes_to_consider_show_good}
       ORDER BY rating DESC
       LIMIT #{@limit}",
      []
    )
  end
end
