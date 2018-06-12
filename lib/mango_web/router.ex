defmodule MangoWeb.Router do
  use MangoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MangoWeb.Plugs.LoadCustomer
    plug MangoWeb.Plugs.FetchCart
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :frontend do
    plug MangoWeb.Plugs.LoadCustomer
    plug MangoWeb.Plugs.FetchCart
    plug MangoWeb.Plugs.Locale
  end

  pipeline :admin do
    plug MangoWeb.Plugs.AdminLayout
    plug MangoWeb.Plugs.LoadAdmin
    plug PhoenixGon.Pipeline
  end

  scope "/", MangoWeb do
    pipe_through [:browser, :frontend]

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create

    get "/cart", CartController, :show
    post "/cart", CartController, :add
    put "/cart", CartController, :update

    get "/", PageController, :index
    get "/categories/:name", CategoryController, :show
  end

  scope "/", MangoWeb do
    pipe_through [:browser, :frontend, MangoWeb.Plugs.AuthenticateCustomer]

    get "/logout", SessionController, :delete
    get "/checkout", CheckoutController, :edit
    put "/checkout/confirm", CheckoutController, :update

    get "/orders", OrderHistoryController, :index
    resources "/tickets", TicketController, except: [:edit, :update, :delete]
  end

  #--- Not Authenticated Admin---#
  scope "/admin", MangoWeb.Admin, as: :admin do
    pipe_through [:browser, :admin]

    get "/login", SessionController, :new
    post "/sendlink", SessionController, :send_link
    get "/magiclink", SessionController, :create
  end

  scope "/admin", MangoWeb.Admin, as: :admin do
    pipe_through [:browser, :admin, MangoWeb.Plugs.AuthenticateAdmin]

    get "/", DashboardController, :show
    resources "/customers", CustomerController, only: [:index, :show]
    resources "/orders", OrderController, only: [:index, :show]
    resources "/users", UserController
    get "/logout", SessionController, :delete

    resources "/warehouse_items", WarehouseItemController
    resources "/suppliers", SupplierController
  end

  # Other scopes may use custom stacks.
  # scope "/api", MangoWeb do
  #   pipe_through :api
  # end
end
