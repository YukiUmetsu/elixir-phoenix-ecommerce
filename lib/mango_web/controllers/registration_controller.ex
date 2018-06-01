defmodule MangoWeb.RegistrationController do
  use MangoWeb, :controller
  alias Mango.CRM

  def new(conn, _params) do
    changeset = CRM.build_customer()
    resident_areas = Mango.Area.ResidenceService.list_areas
    render(conn, "new.html", changeset: changeset, resident_areas: resident_areas)
  end

  def create(conn, %{"registration" => registration_params}) do
    case CRM.create_customer(registration_params) do
      {:ok, _customer} ->
        conn
        |> put_flash(:info, "Registration was successful")
        |> redirect(to: page_path(conn, :index))

      {:error, changeset} ->
        resident_areas = Mango.Area.ResidenceService.list_areas
        changeset = %{changeset | action: :insert, errors: changeset.errors}

        conn
        |> render(:new, changeset: changeset, resident_areas: resident_areas)
    end
  end
end
