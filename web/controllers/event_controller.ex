defmodule Notifilter.EventController do
  @moduledoc false

  use Notifilter.Web, :controller

  alias Notifilter.Elasticsearch

  def index(conn, params) do
    current_page =
      if params["page"] do
        String.to_integer(params["page"])
      else
        0
      end

    name = params["search"]["name"]

    if name != nil && name != "" && name != "All" do
      data = Elasticsearch.latest_events_by_name(name, current_page)
    else
      data = Elasticsearch.latest_events(current_page)
    end

    total = data["hits"]["total"]
    events = data["hits"]["hits"]
    event_names = Elasticsearch.get_fields("name")

    render(
      conn,
      "index.html",
      events: events,
      total_events: total,
      name: name,
      current_page: current_page,
      event_names: event_names
    )
  end

  def show(conn, %{"id" => id}) do
    event = Elasticsearch.event(id)
    data = Poison.encode!(event["data"], pretty: true)
    render(conn, "show.html", event: event, data: data)
  end
end
