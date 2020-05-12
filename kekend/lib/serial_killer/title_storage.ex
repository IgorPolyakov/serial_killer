defmodule SerialKiller.TitleStorage do
  alias :ets, as: Ets

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Ets.new(:title_storage, [:bag, :protected, :named_table])

    shows =
      Postgrex.query!(
        SerialKiller.DB,
        "SELECT title, num_votes, id FROM shows ORDER BY num_votes desc LIMIT 10000",
        []
      ).rows

    build_one_letter_index(shows)
    :ok
  end

  def get(letter) do
    Ets.lookup(:title_storage, letter)
    |> Enum.map(fn row ->
      {_letter, [title, num, id]} = row

      # TODO выглядит, буд-то бы можно сделать красивше, но я пока не придумал
      [title, num, id]
    end)
  end

  defp build_one_letter_index(shows) do
    Enum.each(shows, fn row ->
      String.split(Enum.at(row, 0), " ")
      |> Enum.each(fn word ->
        letters =
          word
          |> String.at(0)
          |> String.downcase()

        Ets.insert(:title_storage, {letters, row})
      end)
    end)
  end
end
