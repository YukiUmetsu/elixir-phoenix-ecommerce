defmodule MangoWeb.HomepageTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

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
