defmodule Notifilter.Router do
  @moduledoc false

  use Notifilter.Web, :router

  pipeline :browser do
    plug(:accepts, ["html", "json"])
    plug(:fetch_session)
    plug(:fetch_flash)
    # plug :protect_from_forgery
    plug(:put_secure_browser_headers)
    plug(Notifilter.Auth)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/health-check", Notifilter do
    get("/", HealthcheckController, :index)
  end

  scope "/", Notifilter do
    pipe_through([:browser, :authenticate_user])

    get("/", NotifierController, :index)

    resources("/notifiers", NotifierController)
    resources("/events", EventController)

    get("/statistics", StatisticController, :index)
    get("/statistics/:event", StatisticController, :show)

    get("/queries", QueryController, :index)
    post("/queries", QueryController, :perform)

    post("/preview", PreviewController, :preview)
  end

  scope "/api", Notifilter do
    pipe_through([:api, :authenticate_api_key])

    get("/statistics", ApiStatisticController, :index)
  end

  scope "/webhooks", Notifilter do
    pipe_through([:api])

    post("/:application/:event", WebhookController, :receive)
  end

  scope "/auth", Notifilter do
    pipe_through(:browser)

    get("/logout", AuthController, :delete)
    get("/google", AuthController, :index)
    get("/google/callback", AuthController, :callback)
    get("/require_auth", PageController, :require_auth)
  end

  def authenticate_api_key(conn, _opts) do
    key = Application.get_env(:notifilter, ApiKey)[:key]

    if conn.params["api_key"] == key do
      conn
    else
      conn
      |> send_resp(403, "")
      |> halt
    end
  end
end
