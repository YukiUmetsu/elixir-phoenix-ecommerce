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

    {:ok, product1 } = Repo.insert %Product{ name: "Carrot", pack_size: "1 kg", price: 55, sku: "A123", is_seasonal: true }
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


    # Add orders
    order_attrs = %{
      "status" => "Confirmed",
      "customer_id" => customer.id,
      "customer_name" => customer.name,
      "email" => customer.email,
      "residence_area" => customer.residence_area,
      "line_items" => [product1, product2],
      "total" => Decimal.new(product1.price+product2.price)
    }
    cart = Sales.create_cart()
    Sales.update_cart(cart, order_attrs)
    :ok
  end

  test "presence of card form for each product" do
    navigate_to("/orders")

    products = find_all_elements(:css, ".orders")

    assert Enum.count(products) !=  0
    IO.inspect(products)
    end)
  end

end