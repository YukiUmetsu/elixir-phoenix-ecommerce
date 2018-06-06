defmodule MangoWeb.OrderHistoryView do
  use MangoWeb, :view
  import Helpers.Dates

  def get_product(item, products) do
    products
    |> Enum.filter(fn(product) -> product.id === item.product_id end)
    |> Enum.map(fn(product) -> product end)
    |> List.first
  end

  def format_date(date) do
    to_mdy(date)
  end
end
