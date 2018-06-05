defmodule Mango.Sales do
  alias Mango.Repo
  alias Mango.Sales.Order
  import Helpers.Types, only: [to_integer: 1]
  import Ecto.Query, only: [from: 2]

  @doc """
  get cart data by id
"""
  def get_cart(id) do
    Order
    |> Repo.get_by(id: id, status: "In Cart")
  end


  @doc """
  create an empty cart
"""
  def create_cart do
    %Order{status: "In Cart"}  |> Repo.insert!()
  end


  @doc """
  add to cart when line_items not exists
"""
  def add_to_cart(%Order{line_items: []} = cart, cart_params) do
    attrs = %{line_items: [cart_params]}
    update_cart(cart, attrs)
  end

  @doc """
  add to cart when line_items exists
"""
  def add_to_cart(%Order{line_items: existing_line_items} = cart, cart_params) do
    new_item = %{
      product_id: to_integer(cart_params["product_id"]),
      quantity: to_integer(cart_params["quantity"])
    }
    add_new_items(cart, new_item, existing_line_items)
  end


  @doc """
  get order changeset
"""
  def change_cart(%Order{} = order) do
    Order.changeset(order, %{})
  end


  @doc """
  update the cart
"""
  def update_cart(cart, attrs) do
    cart
    |> Order.changeset(attrs)
    |> Repo.update
  end


  @doc """
  real logit to add a new item to the existing cart
"""
  def add_new_items(cart, new_item, existing_items_struct) do
    existing_items = existing_items_struct |> Enum.map(&Map.from_struct/1)

    case product_exists?(new_item.product_id, existing_items) do
      [] ->
        attrs = %{line_items: [new_item | existing_items]}
        update_cart(cart, attrs)

      [item] ->
        new_items_attr = get_new_items(item.product_id, existing_items)
        update_cart(cart, new_items_attr)
    end
  end


  @doc """
  checks if certain product already exists in the existing items
"""
  def product_exists?(product_id, items) do
    items
    |> Enum.filter(fn(item) -> product_id == item.product_id end)
  end


  @doc """
  return new line_items. If the same item exists, add 1 to its quantity
"""
  def get_new_items(product_id, existing_items) do
    new_items = existing_items
    |> Enum.map(fn(item) ->
        case item.product_id == product_id do
          true -> Map.put(item, :quantity, item.quantity+1)
          _ -> item
        end
      end)

    %{line_items: new_items}
  end

  @doc """
  check if order submit from checkout form is valid. If valid, update it.
"""
  def confirm_order(%Order{} = order, params) do
    attrs = Map.put(params, "status", "Confirmed")
    order
    |> Order.checkout_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  list the user's checked out orders
"""
  def get_user_orders(customer_id, status) do
    query = case status do
      nil -> from o in Order, where: o.customer_id == ^customer_id, order_by: [desc: o.updated_at]
      _ -> from o in Order, where: o.customer_id == ^customer_id and o.status == ^status, order_by: [desc: o.updated_at]
    end

    Repo.all(query)
  end

end