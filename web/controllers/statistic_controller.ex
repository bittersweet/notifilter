defmodule Notifilter.StatisticController do
  use Notifilter.Web, :controller

  def index(conn, params) do
    event = params["event"]
    type = params["type"]
    field = params["field"]
    data = Notifilter.Aggregator.aggregate(event, type, field)
    render conn, "index.json", %{data: data}
  end
end
