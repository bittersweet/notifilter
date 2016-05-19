defmodule Notifilter.EventController do
  @moduledoc false

  use Notifilter.Web, :controller

  alias Notifilter.Elasticsearch

  def index(conn, _params) do
    events = Elasticsearch.latest_events
    render conn, "index.html", events: events
  end

  def show(conn, %{"id" => id}) do
    event = Elasticsearch.event(id)
    data = Poison.encode!(event["data"], pretty: true)
    render conn, "show.html", event: event, data: data
  end
end
