defmodule Mango.Email do
  import Bamboo.Email
  use Bamboo.Phoenix, view: MangoWeb.EmailView

  def signin_email(email, subject, link) do
    base_email
    |> to(email)
    |> subject(subject)
    |> render("signin.html", link: link)
  end

  defp base_email do
    new_email
    |> from("fromsystem@mydevsquad.com")
    |> put_html_layout({MangoWeb.LayoutView, "email.html"})
  end
end
