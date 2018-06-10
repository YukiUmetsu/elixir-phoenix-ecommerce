defmodule MangoWeb.Admin.SupplierController do
  use MangoWeb, :controller

  alias Mango.Warehourse
  alias Mango.Warehourse.Supplier

  def index(conn, _params) do
    suppliers = Warehourse.list_suppliers()
    render(conn, "index.html", suppliers: suppliers)
  end

  def new(conn, _params) do
    changeset = Warehourse.change_supplier(%Supplier{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"supplier" => supplier_params}) do
    case Warehourse.create_supplier(supplier_params) do
      {:ok, supplier} ->
        conn
        |> put_flash(:info, "Supplier created successfully.")
        |> redirect(to: admin_supplier_path(conn, :show, supplier))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    supplier = Warehourse.get_supplier!(id)
    render(conn, "show.html", supplier: supplier)
  end

  def edit(conn, %{"id" => id}) do
    supplier = Warehourse.get_supplier!(id)
    changeset = Warehourse.change_supplier(supplier)
    render(conn, "edit.html", supplier: supplier, changeset: changeset)
  end

  def update(conn, %{"id" => id, "supplier" => supplier_params}) do
    supplier = Warehourse.get_supplier!(id)

    case Warehourse.update_supplier(supplier, supplier_params) do
      {:ok, supplier} ->
        conn
        |> put_flash(:info, "Supplier updated successfully.")
        |> redirect(to: admin_supplier_path(conn, :show, supplier))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", supplier: supplier, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    supplier = Warehourse.get_supplier!(id)
    {:ok, _supplier} = Warehourse.delete_supplier(supplier)

    conn
    |> put_flash(:info, "Supplier deleted successfully.")
    |> redirect(to: admin_supplier_path(conn, :index))
  end
end
