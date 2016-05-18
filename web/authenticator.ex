defmodule Notifilter.Authenticator do
  def check_user(nil) do
    {:error}
  end

  def check_user(user) do
    [_, domain] = String.split(user.email, "@")
    IO.puts("Domain: #{domain}")

    # TODO: Update this to use config settings, and gmail is too general of
    # course.
    if domain == "gmail.com" do
      {:ok}
    else
      {:error}
    end
  end
end
