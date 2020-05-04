defmodule SerialKiller.Visualizer do
  alias SerialKiller.DB

  def get_ratings(show_id) do
    DB.query!(
      "SELECT e.id, e.season_number, e.episode_number, r.rating, r.num_votes
       FROM episodes AS e
       INNER JOIN ratings AS r ON e.id = r.id
       WHERE e.show_id = $1 ORDER BY r.rating DESC",
      [show_id]
    )
  end
end
