defmodule Notifilter.Elasticsearch do
  def status do
    url = "localhost:9200"
    HTTPoison.get(url, [])
    |> handle_response
  end

  def latest_events do
    url = "localhost:9200/notifilter/event/_search"
    HTTPoison.get(url, [])
    |> handle_response
  end

  def handle_response({ :error, response }) do
  end

  def handle_response({ :ok, response }) do
    Poison.decode!(response.body)
  end
end
