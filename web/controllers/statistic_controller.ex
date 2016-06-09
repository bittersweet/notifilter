defmodule Notifilter.StatisticController do
  use Notifilter.Web, :controller

  def index(conn, _params) do
    data = Notifilter.Aggregator.aggregate("bookings.extend", "terms", "extended_by")
    render conn, "index.json", %{data: data}
  end

  def per_day(conn, _params) do
    data = Notifilter.Aggregator.aggregate("bookings.extend", "terms", "extended_by")
    render conn, "index.json", %{data: data}
  end
end
