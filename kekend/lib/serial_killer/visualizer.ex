defmodule SerialKiller.Visualizer do
  alias SerialKiller.DB

  def get_show_with_episodes(show_id) do
    show = get_show(show_id)

    %{
      show: show,
      episodes: get_episodes(show)
    }
  end

  defp get_show(show_id) do
    shows =
      DB.query!(
        "SELECT * FROM shows WHERE id = $1",
        [show_id]
      )

    case shows do
      [] -> nil
      [show] -> show
    end
  end

  defp get_episodes(nil), do: []

  defp get_episodes(show) do
    DB.query!(
      "SELECT e.id, e.season_number, e.episode_number, r.rating, r.num_votes
       FROM episodes AS e
       INNER JOIN ratings AS r ON e.id = r.id
       WHERE e.show_id = $1 ORDER BY r.rating DESC",
      [show["id"]]
    )
  end
end
