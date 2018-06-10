defmodule MangoWeb.Admin.WarehouseItemControllerTest do
  use MangoWeb.ConnCase

  alias Mango.Warehours

  @create_attrs %{price: "120.5", sku: "some sku", stock_quantity: 42}
  @update_attrs %{price: "456.7", sku: "some updated sku", stock_quantity: 43}
  @invalid_attrs %{price: nil, sku: nil, stock_quantity: nil}

  def fixture(:warehouse_item) do
    {:ok, warehouse_item} = Warehours.create_warehouse_item(@create_attrs)
    warehouse_item
  end

  describe "index" do
    test "lists all warehouse_items", %{conn: conn} do
      conn = get conn, admin_warehouse_item_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Warehouse items"
    end
  end

  describe "new warehouse_item" do
    test "renders form", %{conn: conn} do
      conn = get conn, admin_warehouse_item_path(conn, :new)
      assert html_response(conn, 200) =~ "New Warehouse item"
    end
  end

  describe "create warehouse_item" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, admin_warehouse_item_path(conn, :create), warehouse_item: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == admin_warehouse_item_path(conn, :show, id)

      conn = get conn, admin_warehouse_item_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Warehouse item"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, admin_warehouse_item_path(conn, :create), warehouse_item: @invalid_attrs
      assert html_response(conn, 200) =~ "New Warehouse item"
    end
  end

  describe "edit warehouse_item" do
    setup [:create_warehouse_item]

    test "renders form for editing chosen warehouse_item", %{conn: conn, warehouse_item: warehouse_item} do
      conn = get conn, admin_warehouse_item_path(conn, :edit, warehouse_item)
      assert html_response(conn, 200) =~ "Edit Warehouse item"
    end
  end

  describe "update warehouse_item" do
    setup [:create_warehouse_item]

    test "redirects when data is valid", %{conn: conn, warehouse_item: warehouse_item} do
      conn = put conn, admin_warehouse_item_path(conn, :update, warehouse_item), warehouse_item: @update_attrs
      assert redirected_to(conn) == admin_warehouse_item_path(conn, :show, warehouse_item)

      conn = get conn, admin_warehouse_item_path(conn, :show, warehouse_item)
      assert html_response(conn, 200) =~ "some updated sku"
    end

    test "renders errors when data is invalid", %{conn: conn, warehouse_item: warehouse_item} do
      conn = put conn, admin_warehouse_item_path(conn, :update, warehouse_item), warehouse_item: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Warehouse item"
    end
  end

  describe "delete warehouse_item" do
    setup [:create_warehouse_item]

    test "deletes chosen warehouse_item", %{conn: conn, warehouse_item: warehouse_item} do
      conn = delete conn, admin_warehouse_item_path(conn, :delete, warehouse_item)
      assert redirected_to(conn) == admin_warehouse_item_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, admin_warehouse_item_path(conn, :show, warehouse_item)
      end
    end
  end

  defp create_warehouse_item(_) do
    warehouse_item = fixture(:warehouse_item)
    {:ok, warehouse_item: warehouse_item}
  end
end
