defmodule Notifilter.HealthcheckController do
  @moduledoc false

  use Notifilter.Web, :controller

  def index(conn, _params) do
    send_resp(conn, 200, "")
  end
end
