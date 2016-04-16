defmodule Notifilter.NotifierController do
  use Notifilter.Web, :controller

  alias Notifilter.Notifier

  def index(conn, _params) do
    notifiers = Repo.all(Notifier)
    render conn, "index.html", notifiers: notifiers
  end

  def show(conn, %{"id" => id}) do
    notifier = Repo.get!(Notifier, id)
    render conn, "show.html", notifier: notifier
  end
end
