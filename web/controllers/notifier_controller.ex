defmodule Notifilter.NotifierController do
  use Notifilter.Web, :controller
  require IEx
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

  def create(conn, %{"notifier" => notifier_params}) do
    notifier_params = Map.put(notifier_params, "notification_type", "slack")
    # IEx.pry
    changeset = Notifier.changeset(%Notifier{}, notifier_params)

    case Repo.insert(changeset) do
      {:ok, notifier} ->
        IO.puts("Create worked")
        IO.inspect(notifier)
      {:error, changeset} ->
        IO.puts("errorrr")
        IO.inspect(changeset)
    end

    render conn
  end

  def new(conn, _params) do
    notifier = %Notifier{}
    applications = Poison.encode!(Elasticsearch.get_fields("application"))
    event_names = Poison.encode!(Elasticsearch.get_fields("name"))
    {:ok, notifier_as_json} = notifier |> Map.from_struct |> Map.drop([:__meta__]) |> Poison.encode
    render(conn, "new.html", notifier: notifier, applications: applications, event_names: event_names, notifier_as_json: notifier_as_json)
  end

  def update(conn, %{"id" => id, "notifier" => notifier_params}) do
    notifier = Repo.get!(Notifier, id)
    changeset = Notifier.changeset(notifier, notifier_params)
    case Repo.update(changeset) do
      {:ok, notifier} ->
        IO.inspect(notifier)
      {:error, changeset} ->
        IO.inspect(changeset)
    end

    render conn
  end
end
