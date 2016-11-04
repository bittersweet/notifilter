defmodule Notifilter.WebhookController do
  @moduledoc false

  use Notifilter.Web, :controller

  def receive(conn, params) do
    payload = %{
      application: params["application"],
      identifier: params["event"],
      data: Map.drop(params, ["application", "event"])
    }

    body = Poison.encode!(payload)
    {:ok, socket} = :gen_udp.open(0)
    :gen_udp.send(socket, {127, 0, 0, 1}, 8000, body)

    conn
    |> put_status(:ok)
    |> json(%{status: "success"})
  end
end
