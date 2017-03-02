defmodule Notifilter.NotifierController do
  @moduledoc false

  use Notifilter.Web, :controller
  require IEx
  import Ecto.Query

  alias Notifilter.Notifier
  alias Notifilter.Elasticsearch

  def index(conn, _params) do
    query = from n in Notifier, order_by: [asc: n.id]
    notifiers = Repo.all(query)
    query = from n in Notifier, select: count(n.id)
    count = Repo.one(query)
    render conn, "index.html", count: count, notifiers: notifiers
  end

  def show(conn, %{"id" => id}) do
    notifier = Repo.get!(Notifier, id)
    applications = Poison.encode!(Elasticsearch.get_fields("application"))
    event_names = Poison.encode!(Elasticsearch.get_fields("name"))
    event_keys = Poison.encode!(Elasticsearch.get_event_keys())
    {:ok, notifier_as_json} = notifier
    |> Map.from_struct
    |> Map.put(:eventName, notifier.event_name)
    |> Map.drop([:event_name, :__meta__])
    |> Poison.encode

    render conn, "show.html", notifier: notifier,
      applications: applications,
      event_names: event_names,
      event_keys: event_keys,
      notifier_as_json: notifier_as_json
  end

  def create(conn, %{"notifier" => notifier_params}) do
    notifier_params = Map.put(notifier_params, "notification_type", "slack")
    changeset = Notifier.changeset(%Notifier{}, notifier_params)

    case Repo.insert(changeset) do
      {:ok, _} ->
        IO.puts("Create worked")
      {:error, _} ->
        IO.puts("errorrr")
    end

    render conn
  end

  def new(conn, _params) do
    notifier = %Notifier{application: "",
                         target: "",
                         template: "",
                         event_name: ""}
    applications = Poison.encode!(Elasticsearch.get_fields("application"))
    event_names = Poison.encode!(Elasticsearch.get_fields("name"))
    event_keys = Poison.encode!(Elasticsearch.get_event_keys())
    {:ok, notifier_as_json} = notifier
    |> Map.from_struct
    |> Map.put(:eventName, notifier.event_name)
    |> Map.drop([:event_name, :__meta__])
    |> Poison.encode

    render(conn, "new.html", notifier: notifier,
      applications: applications,
      event_names: event_names,
      event_keys: event_keys,
      notifier_as_json: notifier_as_json)
  end

  def update(conn, %{"id" => id, "notifier" => notifier_params}) do
    notifier = Repo.get!(Notifier, id)
    changeset = Notifier.changeset(notifier, notifier_params)
    case Repo.update(changeset) do
      {:ok, _} ->
        IO.puts("Update worked")
      {:error, _} ->
        IO.puts("errorrr")
    end

    render conn
  end

  def delete(conn, %{"id" => id}) do
    notifier = Repo.get!(Notifier, id)

    Repo.delete!(notifier)

    conn
    |> put_flash(:info, "Notifier deleted")
    |> redirect(to: notifier_path(conn, :index))
  end
end
