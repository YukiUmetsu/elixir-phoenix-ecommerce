defmodule Mango.WarehourseTest do
  use Mango.DataCase

  alias Mango.Warehourse

  describe "suppliers" do
    alias Mango.Warehourse.Supplier

    @valid_attrs %{contact_person: "some contact_person", email: "some email", name: "some name", phone: "some phone"}
    @update_attrs %{contact_person: "some updated contact_person", email: "some updated email", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{contact_person: nil, email: nil, name: nil, phone: nil}

    def supplier_fixture(attrs \\ %{}) do
      {:ok, supplier} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Warehourse.create_supplier()

      supplier
    end

    test "list_suppliers/0 returns all suppliers" do
      supplier = supplier_fixture()
      assert Warehourse.list_suppliers() == [supplier]
    end

    test "get_supplier!/1 returns the supplier with given id" do
      supplier = supplier_fixture()
      assert Warehourse.get_supplier!(supplier.id) == supplier
    end

    test "create_supplier/1 with valid data creates a supplier" do
      assert {:ok, %Supplier{} = supplier} = Warehourse.create_supplier(@valid_attrs)
      assert supplier.contact_person == "some contact_person"
      assert supplier.email == "some email"
      assert supplier.name == "some name"
      assert supplier.phone == "some phone"
    end

    test "create_supplier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warehourse.create_supplier(@invalid_attrs)
    end

    test "update_supplier/2 with valid data updates the supplier" do
      supplier = supplier_fixture()
      assert {:ok, supplier} = Warehourse.update_supplier(supplier, @update_attrs)
      assert %Supplier{} = supplier
      assert supplier.contact_person == "some updated contact_person"
      assert supplier.email == "some updated email"
      assert supplier.name == "some updated name"
      assert supplier.phone == "some updated phone"
    end

    test "update_supplier/2 with invalid data returns error changeset" do
      supplier = supplier_fixture()
      assert {:error, %Ecto.Changeset{}} = Warehourse.update_supplier(supplier, @invalid_attrs)
      assert supplier == Warehourse.get_supplier!(supplier.id)
    end

    test "delete_supplier/1 deletes the supplier" do
      supplier = supplier_fixture()
      assert {:ok, %Supplier{}} = Warehourse.delete_supplier(supplier)
      assert_raise Ecto.NoResultsError, fn -> Warehourse.get_supplier!(supplier.id) end
    end

    test "change_supplier/1 returns a supplier changeset" do
      supplier = supplier_fixture()
      assert %Ecto.Changeset{} = Warehourse.change_supplier(supplier)
    end
  end
end
