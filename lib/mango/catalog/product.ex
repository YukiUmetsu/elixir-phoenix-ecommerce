defmodule Mango.Catalog.Product do
  use Ecto.Schema
  @moduledoc false

  schema "products" do
    field :name, :string
    field :price, :decimal
    field :category, :string
    field :is_seasonal, :boolean, default: false
    field :sku, :string
    field :image, :string
    field :pack_size, :string

    timestamps()
  end
end
