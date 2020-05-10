defmodule SerialKiller.TitleStorage do
  def init do
    :ets.new(:title_storage, [:bag, :protected, :named_table])

    shows =
      Postgrex.query!(
        SerialKiller.DB,
        "SELECT title, num_votes, id FROM shows ORDER BY num_votes desc LIMIT 10000",
        []
      ).rows

    build_one_letter_index(shows)
  end

  defp build_one_letter_index(shows) do
    Enum.each(shows, fn row ->
      String.split(Enum.at(row, 0), " ")
      |> Enum.each(fn word ->
        letters =
          word
          |> String.at(0)
          |> String.downcase()

        :ets.insert(:title_storage, {letters, row})
      end)
    end)
  end
end
