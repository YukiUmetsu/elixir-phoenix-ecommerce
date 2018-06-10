defmodule MangoWeb.Admin.SessionController do
  use MangoWeb, :controller
  alias Mango.Administration
  alias Mango.{Email, Mailer}
  plug :set_layout

  @max_age 1800

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

  def new(conn, _params) do
    conn
    |> render("new.html")
  end

  def send_link(conn, %{"session"=>%{"email"=>email}}) do
    user = Administration.get_admin_by_email(email)
    conn = case user do
      nil -> conn |> put_flash(:error, "Authentication Failed")
      user ->
        link = generate_login_link(conn, user)
        Email.signin_email(email, "Please sign in to Mango from here!", link)
        |> Mailer.deliver_later()
        conn |> put_flash(:info, "Your magic login link is sent to "<>email)
    end
    conn |> render("new.html")
  end

  def create(conn, %{"token" => token}) do
    case verify_token(token) do
      {:ok, user_id } ->
        user = Administration.get_user!(user_id)
        conn
        |> assign(:current_admin, user)
        |> put_session(:admin_id, user.id)
        |> configure_session(renew: true)
        |> put_flash(:info, "Successfully logged in!")
        |> redirect(to: admin_dashboard_path(conn, :show))

      {:error, _} ->
        conn
        |> put_flash(:error, "Authentication error")
        |> render(:new)
    end
  end

  def generate_login_link(conn, user) do
    token = Phoenix.Token.sign(MangoWeb.Endpoint, "user", user.id)
    admin_session_url(conn, :create, %{token: token})
  end

  def delete(conn, _) do
    clear_session(conn)
    |> put_flash(:info, "You have been logged out")
    |> redirect(to: page_path(conn, :index))
  end


  #------------ PRIVATE -----------#
  defp verify_token(token) do
    Phoenix.Token.verify(MangoWeb.Endpoint, "user", token, max_age: @max_age)
  end

  defp set_layout(conn, _) do
    conn
    |> put_layout({MangoWeb.LayoutView, "admin_login.html"})
  end
end