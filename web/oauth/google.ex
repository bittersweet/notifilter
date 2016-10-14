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
    # https://github.com/scrogson/oauth2_example/blob/230e8f2f5a33d70c02fc66e80c1e51eb20121edd/web/oauth/github.ex#L29
    Client.get_token!(client(), Keyword.merge(params, client_secret: client().client_secret))
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
