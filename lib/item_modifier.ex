defmodule ItemModifier do

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
