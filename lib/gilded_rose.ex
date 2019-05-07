defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(item) do
    case item.name do
      "Backstage passes to a TAFKAL80ETC concert" -> BackstagePass.update(item)
      "Aged Brie" -> AgedBrie.update(item)
      "Sulfuras, Hand of Ragnaros" -> item
      "Conjured" -> Conjured.update(item)
      _ -> NormalItem.update(item)
    end
  end

  def update_quality_if(item, condition, change_quality) do
    case condition do
      true -> change_quality.(item)
      false -> item
    end
  end

end

