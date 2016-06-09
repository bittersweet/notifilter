defmodule Notifilter.Router do
  @moduledoc false

  use Notifilter.Web, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Notifilter.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Notifilter do
    pipe_through [:browser, :authenticate_user]

    get "/", NotifierController, :index

    resources "/notifiers", NotifierController
    resources "/events", EventController

    post "/preview", PreviewController, :preview
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Notifilter do
    get "/statistics", StatisticController, :index
  end

  scope "/auth", Notifilter do
    pipe_through :browser

    get "/logout", AuthController, :delete
    get "/google", AuthController, :index
    get "/google/callback", AuthController, :callback
    get "/require_auth", PageController, :require_auth
  end
end
