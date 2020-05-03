defmodule SerialKiller.Hinter do
  alias SerialKiller.DB

  def get_hints(title) do
    DB.query!(
      "SELECT title, id, start_year FROM shows
       WHERE title ILIKE '%' || $1 || '%' LIMIT 10",
      [title]
    )
  end
end
