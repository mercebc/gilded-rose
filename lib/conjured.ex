defmodule Conjured do
  import GildedRose

  def update(item) do
    item
    |> update_quality_if(in_range(item), &(decrease_qualityx2/1))
    |> update_quality_if(in_range(item) and past_sell_date(item), &(decrease_qualityx2/1))
    |> decrease_date
  end

end
