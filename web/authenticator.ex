defmodule Notifilter.Authenticator do
  def check_user(nil) do
    {:error}
  end

  def check_user(user) do
    [_, domain] = String.split(user.email, "@")
    IO.puts("Domain: #{domain}")

    if domain == "springest.com" do
      {:ok}
    else
      {:error}
    end
  end
end
