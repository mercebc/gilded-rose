defmodule AgedBrie do
  import GildedRose

  def update(item) do
    item
    |> update_quality_if(in_range(item), &(increase_quality/1))
    |> update_quality_if(in_range(item) and past_sell_date(item), &(increase_quality/1))
    |> decrease_date
  end

end
