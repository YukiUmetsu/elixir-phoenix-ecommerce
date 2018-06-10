defmodule MangoWeb.Admin.SessionView do
  use MangoWeb, :view

  def render_recaptcha do
    site_key = System.get_env("RECAPTCHA_PUBLIC_KEY")
    raw """
      <script src='https://www.google.com/recaptcha/api.js'></script>
      <button
        class="g-recaptcha"
        data-sitekey="#{site_key}"
        data-callback="YourOnSubmitFn">
        Submit
      </button>
    """
  end
end
