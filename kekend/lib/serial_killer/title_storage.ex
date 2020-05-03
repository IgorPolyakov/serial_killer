defmodule SerialKiller.TitleStorage do
  def init do
    :ets.new(:title_storage, [:set, :protected, :named_table])

    Postgrex.query!(
      SerialKiller.DB,
      "SELECT title, id FROM shows",
      []
    ).rows
    |> Enum.each(fn x -> :ets.insert(:title_storage, {Enum.at(x, 0), Enum.at(x, 1)}) end)
  end
end
