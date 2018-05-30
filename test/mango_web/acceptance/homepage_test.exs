defmodule MangoWeb.HomepageTest do
  use Mango.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    ## GIVEN ##
    alias Mango.Repo
    alias Mango.Catalog.Product

    %Product{ name: "Tomato", price: 55, sku: "A123", is_seasonal: false, category: "vegetables" } |> Repo.insert
    %Product{ name: "Apple", price: 75, sku: "B232", is_seasonal: true, category: "fruits" } |> Repo.insert
  end

  test "presence of featured products" do
    ## GIVEN ##
    # There are two products Apple and Tomato priced at 100 and 50 respectively
    # With Apple being the only seasonal product

    ## WHEN ##
    navigate_to("/")

    ## THEN ##
    page_title = find_element(:css, ".page-title") |> visible_text
    assert page_title == "Seasonal products"

    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text
    product_price = find_within_element(product, :css, ".product-price") |> visible_text

    assert product_name == "Apple"
    assert product_price == "100"
    refute page_source() =~ "Tomato"
  end

end
