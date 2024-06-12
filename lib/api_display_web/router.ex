defmodule ApiDisplayWeb.Router do
  use ApiDisplayWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ApiDisplayWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ApiDisplayWeb do
    pipe_through :browser
    live "/bookings", BookingLive.Index, :index
    live "/bookings/new", BookingLive.Index, :new
    live "/bookings/:id/edit", BookingLive.Index, :edit

    live "/bookings/:id", BookingLive.Show, :show
    live "/bookings/:id/show/edit", BookingLive.Show, :edit
    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", ApiDisplayWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:api_display, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ApiDisplayWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
