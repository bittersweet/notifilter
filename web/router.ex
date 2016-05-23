defmodule Notifilter.Router do
  @moduledoc false

  use Notifilter.Web, :router

  alias Notifilter.Authenticator

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_user
  end

  pipeline :authenticated do
    plug :authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Notifilter do
    pipe_through :browser # Use the default browser stack
    pipe_through :authenticated

    get "/", NotifierController, :index

    resources "/notifiers", NotifierController
    resources "/events", EventController

    post "/preview", PreviewController, :preview
  end

  scope "/auth", Notifilter do
    pipe_through :browser

    get "/logout", AuthController, :delete
    get "/google", AuthController, :index
    get "/google/callback", AuthController, :callback
    get "/require_auth", PageController, :require_auth
  end

  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end

  defp authenticate(conn, _) do
    user = conn.assigns.current_user
    case Authenticator.check_user(user) do
      {:ok} ->
        IO.puts("User checked and validated")
        conn
      {:error} ->
        conn
        |> put_flash(:info, "You are not authorized to view this.")
        |> redirect(to: "/auth/require_auth")
        |> halt
    end
  end

end
