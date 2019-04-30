defmodule ItemModifierTest do
  use ExUnit.Case
  doctest ItemModifier

  test "increases the item's quality by one" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
           |> ItemModifier.increase_quality
    assert item.quality == 4
  end

  test "decresases the item's quality by one" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
           |> ItemModifier.decrease_quality
    assert item.quality == 2
  end

  test "decreases the item's quality by two" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
           |> ItemModifier.decrease_qualityx2
    assert item.quality == 1
  end

  test "decreases the quality to 0" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
           |> ItemModifier.quality_to_0
    assert item.quality == 0
  end

  test "it is in range when item's quality is less than 50" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 49}
    assert ItemModifier.in_range(item) == true
  end

  test "it is in range when item's quality is more than 0" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 1}
    assert ItemModifier.in_range(item) == true
  end

  test "it is not in range if item's quality is 50 " do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 50}
    assert ItemModifier.in_range(item) == false
  end

  test "it is not in range if item's quality is 0" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 0}
    assert ItemModifier.in_range(item) == false
  end

  test "decreases item's sell_in date by one" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}
           |> ItemModifier.decrease_date
    assert item.sell_in == 7
  end

  test "item's sell_in date is in less than 5 days" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 4, quality: 5}
    assert ItemModifier.five_days_left_to_sell(item) == true
  end

  test "item's sell_in date is not in less than 5 days" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 5}
    assert ItemModifier.five_days_left_to_sell(item) == false
  end

  test "item's sell_in date is in less than 10 days" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 7, quality: 9}
    assert ItemModifier.ten_days_left_to_sell(item) == true
  end

  test "item's sell_in date is not in less than 10 days" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 12, quality: 4}
    assert ItemModifier.ten_days_left_to_sell(item) == false
  end

  test "item's sell_in date is today" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 7}
    assert ItemModifier.due_date(item) == true
  end

  test "it is past the item's sell_in date" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: -8, quality: 7}
    assert ItemModifier.past_sell_date(item) == true
  end

  test "it is not past the item's sell_in date" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 7}
    assert ItemModifier.past_sell_date(item) == false
  end

end
