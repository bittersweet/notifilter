defmodule Notifilter.PageController do
  @moduledoc false

  use Notifilter.Web, :controller

  def require_auth(conn, _params) do
    render(conn, "require_auth.html")
  end
end
