defmodule Notifilter.StatisticController do
  use Notifilter.Web, :controller

  def index(conn, params) do
    event = params["event"]
    type = params["type"]
    field = params["field"]

    event_names = Notifilter.Elasticsearch.get_fields("name")
    if Enum.member?(event_names, event) do
      data = Notifilter.Aggregator.aggregate(event, type, field)
      render conn, "index.json", %{data: data}
    else
      data = %{
        error: "key not found",
        possible_keys: event_names,
      }
      render conn, "index.json", %{data: data}
    end
  end
end
