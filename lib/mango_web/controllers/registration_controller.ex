defmodule MangoWeb.RegistrationController do
  use MangoWeb, :controller
  alias Mango.CRM

  def new(conn, _params) do
    changeset = CRM.build_customer()
    render(conn, "new.html", changeset: changeset)
  end
end
