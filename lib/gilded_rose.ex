defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(item) do
    case item.name do
      "Backstage passes to a TAFKAL80ETC concert" -> update_backstage_pass(item)
      "Aged Brie" -> update(item, &(increase_quality/1))
      "Sulfuras, Hand of Ragnaros" -> item
      "Conjured" -> update(item, &(decrease_qualityx2/1))
      _ -> update(item, &(decrease_quality/1))
    end
  end

  defp update_backstage_pass(item) do
    item
    |> update_quality_if(in_range(item), &(increase_quality/1))
    |> update_quality_if(in_range(item) and five_days_left_to_sell(item), &(increase_quality/1))
    |> update_quality_if(in_range(item) and ten_days_left_to_sell(item), &(increase_quality/1))
    |> update_quality_if(due_date(item), &(quality_to_0/1))
    |> decrease_date
  end

  defp update(item, change_quality) do
    item
    |> update_quality_if(in_range(item), change_quality)
    |> update_quality_if(in_range(item) and past_sell_date(item), change_quality)
    |> decrease_date
  end

  def update_quality_if(item, condition, change_quality) do
    if condition do
      change_quality.(item)
    else
      item
    end
  end

  def increase_quality(item) do
    %{item | quality: item.quality + 1}
  end

  def decrease_quality(item) do
    %{item | quality: item.quality - 1}
  end

  def decrease_qualityx2(item) do
    %{item | quality: item.quality - 2}
  end

  def quality_to_0(item) do
    %{item | quality: item.quality - item.quality}
  end

  def in_range(item) do
    0 < item.quality and item.quality < 50
  end

  def decrease_date(item) do
    %{item | sell_in: item.sell_in - 1}
  end

  def five_days_left_to_sell(item) do
    item.sell_in <= 5
  end

  def ten_days_left_to_sell(item) do
    item.sell_in <= 10
  end

  def due_date(item) do
    item.sell_in == 0
  end

  def past_sell_date(item) do
    item.sell_in < 0
  end

end


#   def update_item_old(item) do
#     item = cond do
#       item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
#         if item.quality > 0 do
#           if item.name != "Sulfuras, Hand of Ragnaros" do
#             %{item | quality: item.quality - 1}
#           else
#             item
#           end
#         else
#           item
#         end
#       true ->
#         cond do
#           item.quality < 50 ->
#             item = %{item | quality: item.quality + 1}
#             cond do
#               item.name == "Backstage passes to a TAFKAL80ETC concert" ->
#                 item = cond do
#                   item.sell_in < 11 ->
#                     cond do
#                       item.quality < 50 ->
#                         %{item | quality: item.quality + 1}
#                       true -> item
#                     end
#                   true -> item
#                 end
#                 cond do
#                   item.sell_in < 6 ->
#                     cond do
#                       item.quality < 50 ->
#                         %{item | quality: item.quality + 1}
#                       true -> item
#                     end
#                   true -> item
#                 end
#               true -> item
#             end
#           true -> item
#         end
#     end
#     item = cond do
#       item.name != "Sulfuras, Hand of Ragnaros" ->
#         %{item | sell_in: item.sell_in - 1}
#       true -> item
#     end
#     cond do
#       item.sell_in < 0 ->
#         cond do
#           item.name != "Aged Brie" ->
#             cond do
#               item.name != "Backstage passes to a TAFKAL80ETC concert" ->
#                 cond do
#                   item.quality > 0 ->
#                     cond do
#                       item.name != "Sulfuras, Hand of Ragnaros" ->
#                         %{item | quality: item.quality - 1}
#                       true -> item
#                     end
#                   true -> item
#                 end
#               true -> %{item | quality: item.quality - item.quality}
#             end
#           true ->
#             cond do
#               item.quality < 50 ->
#                 %{item | quality: item.quality + 1}
#               true -> item
#             end
#         end
#       true -> item
#     end
#   end
# end
