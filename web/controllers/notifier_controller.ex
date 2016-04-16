defmodule Notifilter.NotifierController do
  use Notifilter.Web, :controller
  import Ecto.Query

  alias Notifilter.Notifier

  def index(conn, _params) do
    notifiers = Repo.all(Notifier)
    query = from n in Notifier, select: count(n.id)
    count = Repo.one(query)
    render conn, "index.html", count: count, notifiers: notifiers
  end

  def show(conn, %{"id" => id}) do
    notifier = Repo.get!(Notifier, id)
    render conn, "show.html", notifier: notifier
  end
end
