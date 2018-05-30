defmodule MangoWeb.HomepageTest do
  use Mango.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    ## GIVEN ##
  end

  test "presence of featured products" do
    ## GIVEN ##

    ## WHEN ##
    navigate_to("/register")

    ## THEN ##
    form = find_element(:id, "registration-form")
    find_within_element(form, :name, "registration[name]")
    |> fill_field("John")

    find_within_element(form, :name, "registration[email]")
    |> fill_field("john@example.com")

    find_within_element(form, :name, "registration[phone]")
    |> fill_field("1111")

    find_within_element(form, :name, "registration[residence_area]")
    |> fill_field("Area 1")

    find_within_element(form, :name, "registration[password]")
    |> fill_field("password")

    find_within_element(form, :tag, "button")
    |> click

    assert current_path == "/"
    message = find_element(:class, "alert")
              |> visible_text()
    assert message == "Registration successful"
  end

  test "shows error messages on invalid data" do
    navigate_to("/register")

    form = find_element(:id, "registration-form")
    find_within_element(form, :tag, "button") |> click

    assert current_path() == "/register"

    message = find_element(:id, "form-error") |> visible_text()
    assert message == "Oops, something went wrong! Please check the errors below."
  end
end
