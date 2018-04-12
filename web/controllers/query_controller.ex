defmodule Notifilter.QueryController do
  @moduledoc false

  use Notifilter.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html", query: nil, result: nil)
  end

  def perform(conn, %{"query" => query}) do
    body = query["body"]
    result = Notifilter.Aggregator.query(body)
    render(conn, "index.html", query: body, result: result)
  end
end
