defmodule Notifilter.StatisticController do
  use Notifilter.Web, :controller

  def index(conn, params) do
    event_names = Notifilter.Elasticsearch.get_fields("name")

    render conn, "index.html", event_names: event_names
  end

  def show(conn, %{"event" => event}) do
    data = Notifilter.Aggregator.aggregate(event, "terms", nil)
    render conn, "show.html", event: event, data: data
  end
end
