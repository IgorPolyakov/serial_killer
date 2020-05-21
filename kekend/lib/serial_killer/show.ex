defmodule SerialKiller.Show do
  @moduledoc """
  Model representing the show
  """
  alias SerialKiller.DB

  @show_public_fields "id, title, start_year, rating, num_votes"
  @episode_public_fields "id, season_number, episode_number, rating, num_votes"

  # TODO: make limits configurable via query params
  @limit_popular_shows 100
  @limit_best_shows 100
  @limit_search_shows 100

  # TODO: think how to calculte best shows
  @min_num_votes_to_consider_show_good 100_000

  # TODO: cache results
  def get_popular_shows do
    DB.query!(
      "SELECT #{@show_public_fields}
       FROM shows
       ORDER BY num_votes DESC
       LIMIT #{@limit_popular_shows}",
      []
    )
  end

  # TODO: cache results
  def get_best_shows do
    DB.query!(
      "SELECT #{@show_public_fields}
       FROM shows
       WHERE num_votes >= #{@min_num_votes_to_consider_show_good}
       ORDER BY rating DESC
       LIMIT #{@limit_best_shows}",
      []
    )
  end

  def search_shows(words) do
    DB.query!(
      "SELECT #{@show_public_fields}
       FROM shows
       WHERE title_to_tsvector(title) @@ plainto_tsquery('simple', unaccent($1))
       ORDER BY num_votes DESC
       LIMIT #{@limit_search_shows}",
      [words]
    )
  end

  # TODO: rewrite using ETS
  def get_hints(letters) do
    DB.query!(
      "SELECT #{@show_public_fields}
       FROM shows
       WHERE title ILIKE '%' || $1 || '%' LIMIT 10",
      [letters]
    )
  end

  def get_show_with_episodes(show_id) do
    show = get_show(show_id)

    %{
      show: show,
      episodes: get_episodes(show)
    }
  end

  ##############################################################################
  ## Private
  ##############################################################################

  defp get_show(show_id) do
    shows =
      DB.query!(
        "SELECT #{@show_public_fields}
         FROM shows
         WHERE id = $1",
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
      "SELECT #{@episode_public_fields}
       FROM episodes
       WHERE show_id = $1
       ORDER BY (season_number, episode_number)",
      [show_id]
    )
  end
end
