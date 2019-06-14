defmodule ItemModifier do

  def update_quality_if(item, condition, change_quality) do
    case condition do
      true -> change_quality.(item)
      false -> item
    end
  end

  def in_range(item) do
    0 < item.quality and item.quality < 50
  end

  def increase_quality(item) do
    item
    |> update_quality_if(in_range(item), &(%{&1 | quality: &1.quality + 1}))
  end

  def decrease_quality_x2(item) do
    decrease_quality(item, 2)
  end

  def decrease_quality(item) do
    item
    |> update_quality_if(in_range(item), &(%{&1 | quality: &1.quality - 1}))
  end
  def decrease_quality(item, n) when n <= 1, do: decrease_quality(item)
  def decrease_quality(item, n) do
    item
    |> decrease_quality
    |> decrease_quality(n - 1)
  end

  def quality_to_0(item) do
    %{item | quality: item.quality - item.quality}
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
