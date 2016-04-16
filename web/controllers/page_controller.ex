defmodule Notifilter.PageController do
  use Notifilter.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
