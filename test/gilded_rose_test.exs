defmodule GildedRoseTest do
  use ExUnit.Case
  doctest GildedRose

  test "increases the item's quality by one" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
           |>GildedRose.increase_quality
    assert item.quality == 4
  end

  test "decresases the item's quality by one" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
           |>GildedRose.decrease_quality
    assert item.quality == 2
  end

  test "decreases the item's quality by two" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
           |>GildedRose.decrease_qualityx2
    assert item.quality == 1
  end

  test "decreases the quality to 0" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
           |>GildedRose.quality_to_0
    assert item.quality == 0
  end

  test "it is in range when item's quality is less than 50" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 49}
    assert GildedRose.in_range(item) == true
  end

  test "it is in range when item's quality is more than 0" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 1}
    assert GildedRose.in_range(item) == true
  end

  test "it is not in range if item's quality is 50 " do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 50}
    assert GildedRose.in_range(item) == false
  end

  test "it is not in range if item's quality is 0" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 0}
    assert GildedRose.in_range(item) == false
  end

  test "decreases item's sell_in date by one" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
           |> GildedRose.decrease_date
    assert item.sell_in == 7
  end

  test "item's sell_in date is in less than 5 days" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 4, quality: 5}
    assert GildedRose.five_days_left_to_sell(item) == true
  end

  test "item's sell_in date is not in less than 5 days" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 5}
    assert GildedRose.five_days_left_to_sell(item) == false
  end

  test "item's sell_in date is in less than 10 days" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 7, quality: 9}
    assert GildedRose.ten_days_left_to_sell(item) == true
  end

  test "item's sell_in date is not in less than 10 days" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 12, quality: 4}
    assert GildedRose.ten_days_left_to_sell(item) == false
  end

  test "item's sell_in date is today" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 7}
    assert GildedRose.due_date(item) == true
  end

  test "it is past the item's sell_in date" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: -8, quality: 7}
    assert GildedRose.past_sell_date(item) == true
  end

  test "it is not past the item's sell_in date" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 7}
    assert GildedRose.past_sell_date(item) == false
  end

  test "updates item's quality if condition is true" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 7}
           |> GildedRose.update_quality_if(true, &(GildedRose.increase_quality/1))
    assert item.quality == 8
  end

  test "decreases item's quality and decreases sell in date" do
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
