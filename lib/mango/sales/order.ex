defmodule Mango.Sales.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mango.Sales.{Order, LineItem}


  schema "orders" do
    field :state, :string
    field :total, :decimal
    embeds_many :line_items, LineItem, on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:state, :total, :line_items])
    |> validate_required([:state, :total, :line_items])
  end
end
