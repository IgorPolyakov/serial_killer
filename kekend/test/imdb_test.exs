defmodule ImdbTest do
  use ExUnit.Case
  doctest Imdb

  test "greets the world" do
    assert Imdb.hello() == :world
  end
end
