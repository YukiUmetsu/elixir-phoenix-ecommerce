defmodule MangoWeb.Acceptance.OrderHistoryTest do
  use Mango.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    ## GIVEN ##
    # There is a valid registered user
    alias Mango.Repo
    alias Mango.Catalog.Product
    alias Mango.Sales
    alias Mango.CRM

    {:ok, product1 } = Repo.insert %Product{name: "Carrot", pack_size: "1 kg", price: 55, sku: "A123", is_seasonal: true}
    {:ok, product2 } = Repo.insert %Product{ name: "Apple", pack_size: "1 kg", price: 75, sku: "B232", is_seasonal: true }

    # Create customer
    valid_attrs = %{
      "name" => "John",
      "email" => "john@example.com",
      "password" => "secret",
      "residence_area" => "Area 1",
      "phone" => "1111"
    }
    {:ok, customer} = CRM.create_customer(valid_attrs)

    # Login
    navigate_to("/login")

    form = find_element(:id, "session-form")
    find_within_element(form, :name, "session[email]")
    |> fill_field("john@example.com")

    find_within_element(form, :name, "session[password]")
    |> fill_field("secret")

    find_within_element(form, :tag, "button")
    |> click

    item1 =  %{"product_id"=> product1.id, "product_name" => product1.name, "unit_price" => product1.price, "quantity" => 1, "pack_size"=> "1"}
    item2 =  %{"product_id"=> product2.id, "product_name" => product2.name, "unit_price" => product2.price, "quantity" => 1, "pack_size"=> "1"}

    # Add orders
    order_attrs = %{
      "status" => "Confirmed",
      "customer_id" => customer.id,
      "customer_name" => customer.name,
      "email" => customer.email,
      "residence_area" => customer.residence_area,
      "line_items" => [item1, item2],
      "total" => Decimal.new(product1.price+product2.price)
    }
    cart = Sales.create_cart()
    Sales.confirm_order(cart, order_attrs)
    :ok
  end

  test "presence of card form for each product" do
    navigate_to("/orders")
    take_screenshot("./test/screenshots/test.png")
    order_items = find_element(:css, ".order-history")
    product_element = find_within_element(order_items, :css, ".row")
    product_name = find_within_element(product_element, :css, ".item-name") |> visible_text()

    assert product_name == "Carrot"
  end

end