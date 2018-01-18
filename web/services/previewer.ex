defmodule Notifilter.Previewer do
  @moduledoc """
  Previewer talks to our notifilter instance to build previews. We send our data
  and template, and get back the result.
  """

  def preview(data, template) do
    # TODO: make configurable

    url = "127.0.0.1:8000/v1/preview"

    payload = %{
      data: data,
      template: template
    }

    IO.puts("Posting payload to preview endpoint: ")
    IO.inspect(payload)
    body = Poison.encode!(payload)

    {:ok, response} = HTTPoison.post(url, body, [])
    response.body
  end
end
