defmodule Notifilter.EventController do
  @moduledoc false

  use Notifilter.Web, :controller

  alias Notifilter.Elasticsearch

  def index(conn, params) do
    current_page = if params["page"] do
      String.to_integer(params["page"])
    else
      0
    end
    data = Elasticsearch.latest_events(current_page)
    total = data["hits"]["total"]
    events = data["hits"]["hits"]
    render conn, "index.html", events: events, total_events: total, current_page: current_page
  end

  def show(conn, %{"id" => id}) do
    event = Elasticsearch.event(id)
    data = Poison.encode!(event["data"], pretty: true)
    render conn, "show.html", event: event, data: data
  end
end
