defmodule MangoWeb.CheckoutController do
  use MangoWeb, :controller
  alias Mango.Sales

  def edit(conn, _) do
    render conn, "edit.html"
  end
end
