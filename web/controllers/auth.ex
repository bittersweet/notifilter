defmodule Notifilter.Auth do
  import Phoenix.Controller
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user = get_session(conn, :current_user)

    cond do
      # Use already existing assigns if present (test)
      user = conn.assigns[:current_user] ->
        conn
      true ->
        assign(conn, :current_user, user)
    end
  end

  def authenticate_user(conn, _opts) do
    user = conn.assigns.current_user
    case check_user(user) do
      {:ok} ->
        conn
      {:error} ->
        conn
        |> put_flash(:info, "You are not authorized to view this.")
        |> redirect(to: "/auth/require_auth")
        |> halt
    end
  end

  defp check_user(nil) do
    {:error}
  end

  defp check_user(user) do
    [_, domain] = String.split(user.email, "@")

    if domain == "springest.com" do
      {:ok}
    else
      {:error}
    end
  end
end
