defmodule Notifilter.EventController do
  use Notifilter.Web, :controller

  alias Notifilter.Elasticsearch

  def index(conn, _params) do
    events = Elasticsearch.latest_events
    render conn, "index.html", events: events
  end

  def show(conn, %{"id" => id}) do
    event = Elasticsearch.event(id)
    render conn, "show.html", event: event
  end
end
