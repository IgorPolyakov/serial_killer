defmodule SerialKiller.Visualizer do
  alias SerialKiller.DB

  def get_ratings(show_id) do
    DB.query!(
      "SELECT id, season_number, episode_number, rating, num_votes
       FROM episodes
       WHERE show_id = $1
       ORDER BY (season_number, episode_number)",
      [show_id]
    )
  end
end
