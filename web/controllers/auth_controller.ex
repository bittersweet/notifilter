defmodule Notifilter.AuthController do
  use Notifilter.Web, :controller

  def index(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url!(provider)
  end

  def callback(conn, %{"provider" => provider, "code" => code}) do
    token = Google.get_token!(code: code)

    user = get_user!(provider, token)

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

  defp authorize_url!("google"), do: Google.authorize_url!(scope: "https://www.googleapis.com/auth/userinfo.email")

  defp get_token!("google", code), do: Google.get_token!(code: code)

  defp get_user!("google", token) do
    {:ok, %{body: user}} = OAuth2.AccessToken.get(token, "https://www.googleapis.com/plus/v1/people/me/openIdConnect", fields: "id,name")
    IO.puts("get_user!")
    IO.inspect(user)

    %{name: user["name"], avatar: user["picture"], email: user["email"]}
  end
end
