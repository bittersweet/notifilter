defmodule Notifilter.NotifierController do
  use Notifilter.Web, :controller
  import Ecto.Query

  alias Notifilter.Notifier
  alias Notifilter.Elasticsearch

  def index(conn, _params) do
    notifiers = Repo.all(Notifier)
    query = from n in Notifier, select: count(n.id)
    count = Repo.one(query)
    render conn, "index.html", count: count, notifiers: notifiers
  end

  def show(conn, %{"id" => id}) do
    notifier = Repo.get!(Notifier, id)
    applications = Poison.encode!(Elasticsearch.get_fields("application"))
    event_names = Poison.encode!(Elasticsearch.get_fields("name"))
    {:ok, notifier_as_json} = notifier |> Map.from_struct |> Map.drop([:__meta__]) |> Poison.encode
    render conn, "show.html", notifier: notifier, notifier_as_json: notifier_as_json, applications: applications, event_names: event_names
  end
end
