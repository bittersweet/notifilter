defmodule Notifilter.Router do
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
  end

  scope "/auth", Notifilter do
    pipe_through :browser

    get "/logout", AuthController, :delete
    # TODO: provider param can be simplified to Google
    get "/:provider", AuthController, :index
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Notifilter do
  #   pipe_through :api
  # end

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
        |> redirect(to: "/auth/google")
        |> halt
    end
  end

end
