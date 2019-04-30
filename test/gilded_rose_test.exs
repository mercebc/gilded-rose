defmodule GildedRoseTest do
  use ExUnit.Case
  doctest GildedRose

  test "increases normal item's quality" do
    item = %Item{name: "My item", sell_in: 8, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 7
    assert item.quality == 6
  end

  test "decreases item's quality x2 if past the sell in date and decreases sell in date" do
    item = %Item{name: "My item", sell_in: -7, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == -8
    assert item.quality == 5
  end

  test "increases aged brie's quality and decreases sell in date" do
    item = %Item{name: "Aged Brie", sell_in: 8, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 7
    assert item.quality == 8
  end

  test "increases aged brie's quality x2 if past the sell in date and decreases sell in date" do
    item = %Item{name: "Aged Brie", sell_in: -7, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == -8
    assert item.quality == 9
  end

  test "Sulfuras doesnt change quality or sell in date" do
    item = %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 4, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 4
    assert item.quality == 7
  end

  test "decreases conjured item's quality x2 and decreases sell in date" do
    item = %Item{name: "Conjured", sell_in: 16, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 15
    assert item.quality == 5
  end

  test "decreases conjured item's quality x4 if past the sell in date and decreases sell in date" do
    item = %Item{name: "Conjured", sell_in: -7, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == -8
    assert item.quality == 3
  end

  test "decreases backstage pass' quality by one when more than 10 days left" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 20, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 19
    assert item.quality == 8
  end

  test "decreases backstage pass' quality by two when less than 10 days left" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 8
    assert item.quality == 9
  end

  test "decreases backstage pass' quality by three when less than 5 days left" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 4, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == 3
    assert item.quality == 10
  end

  test "decreases backstage pass' quality to 0 on the day of the event" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 7}
           |> GildedRose.update_item
    assert item.sell_in == -1
    assert item.quality == 0
  end

end
