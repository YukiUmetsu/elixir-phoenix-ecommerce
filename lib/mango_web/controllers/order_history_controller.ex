defmodule MangoWeb.OrderHistoryController do
  use MangoWeb, :controller
  alias Mango.Sales
  alias Mango.Catalog
  alias Mango.Sales.Order

  def index(conn, _params) do
    customer = conn.assigns.current_customer
    orders = Sales.get_user_orders(customer.id, "Confirmed")
    products = get_products_from_orders(orders)
    render(conn, "index.html", orders: orders, products: products)
  end

  def get_products_from_orders(orders) do
    products = Map.new()
    product_ids = orders
    |> Enum.flat_map(fn(order) -> order.line_items end)
    |> Enum.flat_map(fn(item) -> [item.product_id] end)
    Catalog.get_products!(product_ids)
  end
end
