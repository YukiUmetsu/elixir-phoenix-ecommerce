defmodule MangoWeb.LayoutView do
  use MangoWeb, :view
  import MangoWeb.CartView, only: [cart_count: 1]

  def cart_link_text(conn) do
    raw """
      <i class="fa fa-shopping-cart" aria-hidden="true"></i>
      <span class="cart-count">#{cart_count(conn)}</span>
    """
  end
end
