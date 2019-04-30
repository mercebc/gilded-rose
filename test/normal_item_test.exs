defmodule NormalItemTest do
  use ExUnit.Case
  doctest NormalItem

  test "decreases item's quality and decreases sell in date" do
    item = %Item{name: "My item", sell_in: 8, quality: 7}
           |> NormalItem.update
    assert item.sell_in == 7
    assert item.quality == 6
  end

  test "decreases item's quality x2 if past the sell in date and decreases sell in date" do
    item = %Item{name: "My item", sell_in: -7, quality: 7}
           |> NormalItem.update
    assert item.sell_in == -8
    assert item.quality == 5
  end

end
