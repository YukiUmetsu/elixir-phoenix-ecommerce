defmodule MangoWeb.OrderHistoryController do
  use MangoWeb, :controller
  alias Mango.Sales
  alias Mango.Catalog
  alias Mango.Sales.Order

  # TODO
  require IEx

  def index(conn, _params) do
    customer = conn.assigns.current_customer
    orders = Sales.get_user_orders(customer.id, "Confirmed")
    products = get_products_from_orders(orders)
    render(conn, "index.html", orders: orders, products: products)
  end

  def get_products_from_orders(orders) do
    products = Map.new()
    orders
    |> Enum.flat_map(fn(order) -> order.line_items end)
    |> Enum.flat_map(fn(item) ->
      product = Catalog.get_product!(item.product_id)
      [product]
    end)
  end
end
