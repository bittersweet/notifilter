defmodule Notifilter.EventController do
  use Notifilter.Web, :controller

  alias Notifilter.Elasticsearch

  def index(conn, _params) do
    status = Elasticsearch.status
    render conn, "index.html", status: status
  end
end
