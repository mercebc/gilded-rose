defmodule NormalItem do
  import ItemModifier

  def update(item) do
    item
    |> decrease_quality
    |> update_quality_if(past_sell_date(item), &(decrease_quality/1))
    |> decrease_date
  end

end
