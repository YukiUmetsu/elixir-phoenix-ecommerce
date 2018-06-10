defmodule MangoWeb.Admin.OrderController do
  use MangoWeb, :controller
  alias Mango.Sales
  alias Mango.Catalog

  def index(conn, _params) do
    admin = conn.assigns.current_admin
    orders = Sales.get_oders()
    products = get_products_from_orders(orders)
    render(conn, "index.html", orders: orders, products: products)
  end

  def show(conn, %{"id" => id}) do
    order = Sales.get_order!(id)
    render(conn, "show.html", order: order)
  end

  def get_products_from_orders(orders) do
    product_ids = orders
    |> Enum.flat_map(fn(order) -> order.line_items end)
    |> Enum.flat_map(fn(item) -> [item.product_id] end)
    Catalog.get_products!(product_ids)
  end
end
