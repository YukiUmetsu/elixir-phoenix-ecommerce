defmodule Mango.Warehours do
  @moduledoc """
  The Warehours context.
  """

  import Ecto.Query, warn: false
  alias Mango.Repo

  alias Mango.Warehours.WarehouseItem

  @doc """
  Returns the list of warehouse_items.

  ## Examples

      iex> list_warehouse_items()
      [%WarehouseItem{}, ...]

  """
  def list_warehouse_items do
    Repo.all(WarehouseItem)
  end

  @doc """
  Gets a single warehouse_item.

  Raises `Ecto.NoResultsError` if the Warehouse item does not exist.

  ## Examples

      iex> get_warehouse_item!(123)
      %WarehouseItem{}

      iex> get_warehouse_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_warehouse_item!(id), do: Repo.get!(WarehouseItem, id)

  @doc """
  Creates a warehouse_item.

  ## Examples

      iex> create_warehouse_item(%{field: value})
      {:ok, %WarehouseItem{}}

      iex> create_warehouse_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_warehouse_item(attrs \\ %{}) do
    %WarehouseItem{}
    |> WarehouseItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a warehouse_item.

  ## Examples

      iex> update_warehouse_item(warehouse_item, %{field: new_value})
      {:ok, %WarehouseItem{}}

      iex> update_warehouse_item(warehouse_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_warehouse_item(%WarehouseItem{} = warehouse_item, attrs) do
    warehouse_item
    |> WarehouseItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a WarehouseItem.

  ## Examples

      iex> delete_warehouse_item(warehouse_item)
      {:ok, %WarehouseItem{}}

      iex> delete_warehouse_item(warehouse_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_warehouse_item(%WarehouseItem{} = warehouse_item) do
    Repo.delete(warehouse_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking warehouse_item changes.

  ## Examples

      iex> change_warehouse_item(warehouse_item)
      %Ecto.Changeset{source: %WarehouseItem{}}

  """
  def change_warehouse_item(%WarehouseItem{} = warehouse_item) do
    WarehouseItem.changeset(warehouse_item, %{})
  end
end
