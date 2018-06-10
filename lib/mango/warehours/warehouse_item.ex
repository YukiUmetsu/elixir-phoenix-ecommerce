defmodule Mango.Warehours.WarehouseItem do
  use Ecto.Schema
  import Ecto.Changeset


  schema "warehouse_items" do
    field :price, :decimal
    field :sku, :string
    field :stock_quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(warehouse_item, attrs) do
    warehouse_item
    |> cast(attrs, [:sku, :price, :stock_quantity])
    |> validate_required([:sku, :price, :stock_quantity])
  end
end
