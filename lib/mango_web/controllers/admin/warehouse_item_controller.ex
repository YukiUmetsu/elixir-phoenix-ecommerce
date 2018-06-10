defmodule MangoWeb.Admin.WarehouseItemController do
  use MangoWeb, :controller

  alias Mango.Warehours
  alias Mango.Warehours.WarehouseItem

  def index(conn, _params) do
    warehouse_items = Warehours.list_warehouse_items()
    render(conn, "index.html", warehouse_items: warehouse_items)
  end

  def new(conn, _params) do
    changeset = Warehours.change_warehouse_item(%WarehouseItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"warehouse_item" => warehouse_item_params}) do
    case Warehours.create_warehouse_item(warehouse_item_params) do
      {:ok, warehouse_item} ->
        conn
        |> put_flash(:info, "Warehouse item created successfully.")
        |> redirect(to: admin_warehouse_item_path(conn, :show, warehouse_item))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    warehouse_item = Warehours.get_warehouse_item!(id)
    render(conn, "show.html", warehouse_item: warehouse_item)
  end

  def edit(conn, %{"id" => id}) do
    warehouse_item = Warehours.get_warehouse_item!(id)
    changeset = Warehours.change_warehouse_item(warehouse_item)
    render(conn, "edit.html", warehouse_item: warehouse_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "warehouse_item" => warehouse_item_params}) do
    warehouse_item = Warehours.get_warehouse_item!(id)

    case Warehours.update_warehouse_item(warehouse_item, warehouse_item_params) do
      {:ok, warehouse_item} ->
        conn
        |> put_flash(:info, "Warehouse item updated successfully.")
        |> redirect(to: admin_warehouse_item_path(conn, :show, warehouse_item))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", warehouse_item: warehouse_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    warehouse_item = Warehours.get_warehouse_item!(id)
    {:ok, _warehouse_item} = Warehours.delete_warehouse_item(warehouse_item)

    conn
    |> put_flash(:info, "Warehouse item deleted successfully.")
    |> redirect(to: admin_warehouse_item_path(conn, :index))
  end
end
