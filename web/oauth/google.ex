defmodule Google do
  @moduledoc """
  An OAuth 2 strategy.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode
  alias OAuth2.Client

  defp config do
    [strategy: Google,
     site: "https://accounts.google.com",
     authorize_url: "/o/oauth2/auth",
     token_url: "/o/oauth2/token"]
  end

  @lint {~r/Refactor/, false}
  def client do
    Application.get_env(:notifilter, Google)
    |> Keyword.merge(config())
    |> Client.new()
  end

  def authorize_url!(params \\ []) do
    Client.authorize_url!(client(), params)
  end

  def get_token!(params \\ [], headers \\ []) do
    Client.get_token!(client(), params)
  end

  def authorize_url(oauth_client, params) do
    AuthCode.authorize_url(oauth_client, params)
  end

  # Will be called via lib/oauth2/client.ex
  def get_token(oauth_client, params, headers) do
    oauth_client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
