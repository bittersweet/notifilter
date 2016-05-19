defmodule Notifilter.AuthController do
  @moduledoc false

  use Notifilter.Web, :controller
  alias OAuth2.AccessToken

  def index(conn, _params) do
    scope = "https://www.googleapis.com/auth/userinfo.email"
    authorize_url = Google.authorize_url!(scope: scope)
    redirect conn, external: authorize_url
  end

  def callback(conn, %{"code" => code}) do
    token = Google.get_token!(code: code)

    user = get_user!(token)

    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, token.access_token)
    |> redirect(to: "/")
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  defp get_user!(token) do
    token_url = "https://www.googleapis.com/plus/v1/people/me/openIdConnect"
    {:ok, %{body: user}} = AccessToken.get(token, token_url, fields: "id,name")

    %{name: user["name"], avatar: user["picture"], email: user["email"]}
  end
end
