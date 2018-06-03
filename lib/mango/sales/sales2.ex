#defmodule Mango.Sales2 do
#  alias Mango.Repo
#  alias Mango.Sales.Order
#  alias Mango.Sales.LineItem
#  # TODO erase
#  require IEx
#
#  def get_cart(id) do
#    Order
#    |> Repo.get_by(id: id, status: "In Cart")
#  end
#
#  def create_cart do
#    %Order{ status: "In Cart" } |> Repo.insert!()
#  end
#
#  @doc """
#  add an item to the empty cart
#"""
#  def add_to_cart(%Order{line_items: []} = cart, cart_params) do
#    IEx.pry
#    attr = %{line_items: [cart_params]}
#    update_cart(cart, attr)
#  end
#
#  @doc """
#  add an item to non-empty cart
#"""
#  def add_to_cart(%Order{line_items: existing_line_items} = cart, cart_params) do
#    IEx.pry
#    new_item = %{
#      product_id: String.to_integer(cart_params["product_id"]),
#      quantity: String.to_integer(cart_params["quantity"])
#    }
#    get_new_items(cart, new_item, existing_line_items)
#  end
#
#  def get_new_items(cart, new_item, existing_items_struct) do
#    same_product_id = nil
#    existing_items = existing_items_struct |> Enum.map(&Map.from_struct/1)
#    product_id = Enum.reduce(existing_items, fn(existing_item) ->
#            if existing_item.product_id === new_item.product_id do
#              same_product_id = existing_item.product_id
#            end
#            same_product_id
#        end)
#
#    product_id
#    |> get_new_cart(new_item, existing_items)
#    |> update_cart(cart)
#  end
#
#  def get_new_cart(product_id, new_item, existing_items) do
#    new_cart_attr =
#      case is_integer(product_id) do
#        true ->
#          updated_items = Enum.map(existing_items, fn(existing_item) ->
#            if existing_item.product_id === new_item.product_id do
#              %LineItem{existing_item | quantity: existing_item.quantity+1 }
#            end
#            existing_item
#          end)
#          %{line_items: [updated_items]}
#
#        _ -> %{line_items: [new_item | existing_items]}
#      end
#  end
#
#  def update_cart(attr, cart) do
#    cart
#    |> Order.changeset(attr)
#    |> Repo.update
#  end
#end
