defmodule SerialKiller.Hinter do
  alias SerialKiller.DB

  def get_hints(letters) do
    DB.query!(
      "SELECT title, id, start_year FROM shows
       WHERE title ILIKE '%' || $1 || '%' LIMIT 10",
      [letters]
    )
  end
end
