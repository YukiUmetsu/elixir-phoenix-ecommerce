defmodule Mango.Catalog do
  import Ecto.Query, only: [from: 2]

  @moduledoc false
  alias Mango.Catalog.Product
  alias Mango.Repo

  def list_products() do
    Product
    |> Repo.all
  end

  def list_seasonal_products() do
    list_products()
    |> Enum.filter(fn(product) -> product.is_seasonal == true end)
  end

  def get_category_products(name) do
    list_products()
    |> Enum.filter(fn(product) -> product.category == name end)
  end

  def get_product!(id), do: Product |> Repo.get(id)

  def get_products!(ids) do
    query = from p in Product, where: p.id in ^ids
    Repo.all(query)
  end
end
