defmodule BackstagePass do
  import ItemModifier

  def update(item) do
    item
    |> update_quality_if(in_range(item), &(increase_quality/1))
    |> update_quality_if(in_range(item) and five_days_left_to_sell(item), &(increase_quality/1))
    |> update_quality_if(in_range(item) and ten_days_left_to_sell(item), &(increase_quality/1))
    |> update_quality_if(due_date(item), &(quality_to_0/1))
    |> decrease_date
  end

  def update_quality_if(item, condition, change_quality) do
    case condition do
      true -> change_quality.(item)
      false -> item
    end
  end

end
