defmodule Conjured do
  import ItemModifier

  def update(item) do
    item
    |> decrease_quality_x2
    |> update_quality_if(past_sell_date(item), &(decrease_quality_x2/1))
    |> decrease_date
  end


  # def update(item) do
  #   decrease_date(update_quality_if(decrease_quality_x2(item),past_sell_date(item), &(decrease_quality_x2/1)))
  # end

end
