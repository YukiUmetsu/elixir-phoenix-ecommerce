defmodule MangoWeb.OrderHistoryController do
  use MangoWeb, :controller
  alias Mango.Sales

  def index(conn, _params) do
    customer = conn.assigns.current_customer
    orders = Sales.get_user_orders(customer.id, "Confirmed")
    render(conn, "index.html", orders: orders)
  end
end
