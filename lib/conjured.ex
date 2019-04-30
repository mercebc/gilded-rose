defmodule Conjured do
  import ItemModifier

  def update(item) do
    item
    |> update_quality_if(in_range(item), &(decrease_qualityx2/1))
    |> update_quality_if(in_range(item) and past_sell_date(item), &(decrease_qualityx2/1))
    |> decrease_date
  end

  def update_quality_if(item, condition, change_quality) do
    case condition do
      true -> change_quality.(item)
      false -> item
    end
  end

end
