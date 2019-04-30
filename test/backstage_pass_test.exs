defmodule BackstagePassTest do
  use ExUnit.Case
  doctest BackstagePass

  test "decreases backstage pass' quality by one when more than 10 days left" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 20, quality: 7}
           |> BackstagePass.update
    assert item.sell_in == 19
    assert item.quality == 8
  end

  test "decreases backstage pass' quality by two when less than 10 days left" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 7}
           |> BackstagePass.update
    assert item.sell_in == 8
    assert item.quality == 9
  end

  test "decreases backstage pass' quality by three when less than 5 days left" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 4, quality: 7}
           |> BackstagePass.update
    assert item.sell_in == 3
    assert item.quality == 10
  end

  test "decreases backstage pass' quality to 0 on the day of the event" do
    item = %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 7}
           |> BackstagePass.update
    assert item.sell_in == -1
    assert item.quality == 0
  end

end
