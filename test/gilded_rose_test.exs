defmodule GildedRoseTest do
  use ExUnit.Case
  doctest GildedRose

  test "updates a normal item" do
    item = %Item{name: "My item", sell_in: 8, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 7
    assert item.quality == 6
  end

  test "updates an aged brie" do
    item = %Item{name: "Aged Brie", sell_in: 8, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 7
    assert item.quality == 8
  end

  test "doesnt change a Sulfuras" do
    item = %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 4, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 4
    assert item.quality == 7
  end

  test "updates a conjured item" do
    item = %Item{name: "Conjured", sell_in: 16, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 15
    assert item.quality == 5
  end

  test "updates a backstage pass" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 8
    assert item.quality == 9
  end

end
