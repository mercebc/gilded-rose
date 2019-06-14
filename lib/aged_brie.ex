defmodule AgedBrie do
  import ItemModifier

  def update(item) do
    item
    |> increase_quality
    |> update_quality_if(past_sell_date(item), &(increase_quality/1))
    |> decrease_date
  end

end
