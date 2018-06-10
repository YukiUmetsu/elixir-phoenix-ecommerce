defmodule Mango.WarehoursTest do
  use Mango.DataCase

  alias Mango.Warehours

  describe "warehouse_items" do
    alias Mango.Warehours.WarehouseItem

    @valid_attrs %{price: "120.5", sku: "some sku", stock_quantity: 42}
    @update_attrs %{price: "456.7", sku: "some updated sku", stock_quantity: 43}
    @invalid_attrs %{price: nil, sku: nil, stock_quantity: nil}

    def warehouse_item_fixture(attrs \\ %{}) do
      {:ok, warehouse_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Warehours.create_warehouse_item()

      warehouse_item
    end

    test "list_warehouse_items/0 returns all warehouse_items" do
      warehouse_item = warehouse_item_fixture()
      assert Warehours.list_warehouse_items() == [warehouse_item]
    end

    test "get_warehouse_item!/1 returns the warehouse_item with given id" do
      warehouse_item = warehouse_item_fixture()
      assert Warehours.get_warehouse_item!(warehouse_item.id) == warehouse_item
    end

    test "create_warehouse_item/1 with valid data creates a warehouse_item" do
      assert {:ok, %WarehouseItem{} = warehouse_item} = Warehours.create_warehouse_item(@valid_attrs)
      assert warehouse_item.price == Decimal.new("120.5")
      assert warehouse_item.sku == "some sku"
      assert warehouse_item.stock_quantity == 42
    end

    test "create_warehouse_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warehours.create_warehouse_item(@invalid_attrs)
    end

    test "update_warehouse_item/2 with valid data updates the warehouse_item" do
      warehouse_item = warehouse_item_fixture()
      assert {:ok, warehouse_item} = Warehours.update_warehouse_item(warehouse_item, @update_attrs)
      assert %WarehouseItem{} = warehouse_item
      assert warehouse_item.price == Decimal.new("456.7")
      assert warehouse_item.sku == "some updated sku"
      assert warehouse_item.stock_quantity == 43
    end

    test "update_warehouse_item/2 with invalid data returns error changeset" do
      warehouse_item = warehouse_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Warehours.update_warehouse_item(warehouse_item, @invalid_attrs)
      assert warehouse_item == Warehours.get_warehouse_item!(warehouse_item.id)
    end

    test "delete_warehouse_item/1 deletes the warehouse_item" do
      warehouse_item = warehouse_item_fixture()
      assert {:ok, %WarehouseItem{}} = Warehours.delete_warehouse_item(warehouse_item)
      assert_raise Ecto.NoResultsError, fn -> Warehours.get_warehouse_item!(warehouse_item.id) end
    end

    test "change_warehouse_item/1 returns a warehouse_item changeset" do
      warehouse_item = warehouse_item_fixture()
      assert %Ecto.Changeset{} = Warehours.change_warehouse_item(warehouse_item)
    end
  end
end
