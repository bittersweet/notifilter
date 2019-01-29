defmodule Notifilter.AuthController do
  @moduledoc false

  use Notifilter.Web, :controller

  def index(conn, _params) do
    scope = "https://www.googleapis.com/auth/userinfo.email"
    authorize_url = Google.authorize_url!(scope: scope, hd: "springest.com")
    redirect(conn, external: authorize_url)
  end

  def callback(conn, %{"code" => code}) do
    client = Google.get_token!(code: code)

    user = get_user!(client)

    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  defp get_user!(token) do
    token_url = "https://www.googleapis.com/oauth2/v3/userinfo"
    {:ok, %{body: user}} = OAuth2.Client.get(token, token_url, fields: "id,name")

    %{name: user["name"], avatar: user["picture"], email: user["email"]}
  end
end
