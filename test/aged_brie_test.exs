defmodule AgedBrieTest do
  use ExUnit.Case
  doctest AgedBrie

  test "increases aged brie's quality and decreases sell in date" do
    item = %Item{name: "Aged Brie", sell_in: 8, quality: 7}
           |> AgedBrie.update
    assert item.sell_in == 7
    assert item.quality == 8
  end

  test "increases aged brie's quality x2 if past the sell in date and decreases sell in date" do
    item = %Item{name: "Aged Brie", sell_in: -7, quality: 7}
           |> AgedBrie.update
    assert item.sell_in == -8
    assert item.quality == 9
  end

end
