defmodule MangoWeb.Plugs.AdminLayout do
  import Phoenix.Controller, only: [put_layout: 2]

  def init(_opts), do: nil

  def call(conn, _opts) do
    conn
    |> put_layout({MongoWeb.LayoutView, "admin_app.html"})
  end
end
