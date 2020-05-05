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

  defp get_episodes(%{"id" => show_id}) do
    DB.query!(
      "SELECT id, season_number, episode_number, rating, num_votes
       FROM episodes
       WHERE show_id = $1
       ORDER BY (season_number, episode_number)",
      [show_id]
    )
  end
end
