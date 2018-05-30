defmodule MangoWeb.CategoryPageTest do
  use Mango.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    ## GIVEN ##
    alias Mango.Repo
    alias Mango.Catalog.Product

    %Product{ name: "Tomato", price: 50, sku: "A123", is_seasonal: false, category: "vegetables" } |> Repo.insert
    %Product{ name: "Apple", price: 100, sku: "B232", is_seasonal: true, category: "fruits" } |> Repo.insert
  end

  test "show fruits" do
    ## WHEN ##
    navigate_to("/categories/fruits")

    ## THEN ##
    page_title = find_element(:css, ".page-title") |> visible_text()
    assert page_title == "Fruits"

    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text()
    product_price = find_within_element(product, :css, ".product-price") |> visible_text()

    assert product_name == "Apple"
    assert product_price == "100"
    refute page_source() =~ "Tomato"
  end

  test "show vegetables" do
    ## WHEN ##
    navigate_to("/categories/vegetables")

    ## THEN ##
    page_title = find_element(:css, ".page-title") |> visible_text()
    assert page_title == "Vegetables"

    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text()
    product_price = find_within_element(product, :css, ".product-price") |> visible_text()

    assert product_name == "Tomato"
    assert product_price == "50"
    refute page_source() =~ "Apple"
  end

end
