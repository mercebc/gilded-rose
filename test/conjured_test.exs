defmodule ConjuredTest do
  use ExUnit.Case
  doctest Conjured

  test "decreases conjured item's quality x2 and decreases sell in date" do
    item = %Item{name: "Conjured", sell_in: 16, quality: 7}
           |> Conjured.update
    assert item.quality == 5
  end

  test "decreases conjured item's quality x4 if past the sell in date and decreases sell in date" do
    item = %Item{name: "Conjured", sell_in: -7, quality: 7}
           |> Conjured.update
    assert item.quality == 3
  end

  test "decreases conjured item's quality x4 if past the sell in date and decreases sell in date 2" do
    item = %Item{name: "Conjured", sell_in: -7, quality: 3}
           |> Conjured.update
    assert item.quality == 0
  end

  test "decreaes conjured item's sell in date" do
    item = %Item{name: "Conjured", sell_in: 16, quality: 7}
           |> Conjured.update
    assert item.sell_in == 15
  end

end
