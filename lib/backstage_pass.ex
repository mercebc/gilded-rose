defmodule BackstagePass do
  import ItemModifier

  def update(item) do
    item
    |> increase_quality
    |> update_quality_if(five_days_left_to_sell(item), &(increase_quality/1))
    |> update_quality_if(ten_days_left_to_sell(item), &(increase_quality/1))
    |> update_quality_if(due_date(item), &(quality_to_0/1))
    |> decrease_date
  end

end
