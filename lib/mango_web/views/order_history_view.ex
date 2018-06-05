defmodule MangoWeb.OrderHistoryView do
  use MangoWeb, :view

  def render_products(products) do
    products
    |> Enum.map(fn(product) -> format_product(product) end)
    |> Enum.join(", ")
  end

  def format_product(product) do
    "#{product.product_name} (#{product.quantity})"
  end
end
