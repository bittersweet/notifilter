defmodule Notifilter.Authenticator do
  @moduledoc """
  Authenticator checks if the passed in user is allowed into our app.
  """

  def check_user(nil) do
    {:error}
  end

  def check_user(user) do
    [_, domain] = String.split(user.email, "@")

    if domain == "springest.com" do
      {:ok}
    else
      {:error}
    end
  end
end
