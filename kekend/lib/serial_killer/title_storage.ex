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
        "SELECT title, num_votes, id FROM shows ORDER BY num_votes desc LIMIT 100",
        []
      ).rows

    build_letters_index(shows)
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

  @doc """
  shows -> [["Game of Thrones", 1668725, "tt0944947"]]
  """
  defp build_letters_index(shows) do
    Enum.each(shows, fn row ->
      show = Enum.at(row, 0)

      String.split(show, " ")
      |> Enum.each(fn word ->
        first_letter = function_name(word, 0)
        set_to_title_storage(first_letter, row)

        second_letter = function_name(word, 1)
        set_to_title_storage("#{first_letter}#{second_letter}", row)

        third_letter = function_name(word, 2)
        set_to_title_storage("#{first_letter}#{second_letter}#{third_letter}", row)

        four_letter = function_name(word, 3)
        set_to_title_storage("#{first_letter}#{second_letter}#{third_letter}#{four_letter}", row)
      end)
    end)
  end

  defp set_to_title_storage(index, show) do
    Ets.insert(
      :title_storage,
      {index, show}
    )
  end

  defp function_name(word, deep) do
    word
    |> String.at(deep)
    |> prepare_letter
  end

  defp prepare_letter(letter) do
    cond do
      letter == nil -> ""
      String.match?(letter, ~r/\w/) -> String.downcase(letter)
      true -> ""
    end
  end
end

# SerialKiller.TitleStorage.init(:ok)
