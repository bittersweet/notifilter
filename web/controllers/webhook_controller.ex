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
    hostname = Application.get_env(:notifilter, Receive)[:hostname]
    :gen_udp.send(socket, String.to_atom(hostname), 8000, body)

    conn
    |> put_status(:ok)
    |> json(%{status: "success"})
  end
end
