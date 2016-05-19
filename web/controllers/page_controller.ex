defmodule Notifilter.PageController do
  @moduledoc false

  use Notifilter.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def require_auth(conn, _params) do
    render conn, "require_auth.html"
  end
end
