defmodule Notifilter.Elasticsearch do
  @moduledoc """
  Elasticsearch talks to the ES service and gives back latest events or specific
  events, all known fields and applications.
  """

  def status do
    "localhost:9200"
    |> HTTPoison.get([])
    |> handle_response
  end

  def latest_events do
    "localhost:9200/notifilter/event/_search"
    |> HTTPoison.get([])
    |> handle_response
  end

  def event(event_id) do
    url = "localhost:9200/notifilter/event/#{event_id}"
    {:ok, response} = HTTPoison.get(url, [])
    Poison.decode!(response.body)["_source"]
  end

  @doc """
  Query ES for all known applications we have seen so far.
  """
  def get_fields(field) do
    url = "localhost:9200/notifilter/event/_search"
    headers = []
    query = %{
      "size": 0,
      "aggs": %{
        "field": %{
          "terms": %{
            "field": field,
            "size": 0, # Make sure we get all results, not limited
            "order": %{
              "_term": "asc"
            }
            }
          }
      }
    }
    body = Poison.encode!(query)
    {:ok, response} = HTTPoison.post(url, body, headers)
    result = Poison.decode!(response.body)
    keys = result["aggregations"]["field"]["buckets"]
    Enum.map(keys, fn(bucket) -> bucket["key"] end)
  end

  def applications do
    url = "localhost:9200/notifilter/event/_search"
    headers = []
    query = %{
      "size": 0,
      "aggs": %{
        "applications": %{
          "terms": %{
            "field": "application",
            "size": 0, # Make sure we get all results, not limited
            "order": %{
              "_term": "asc"
            }
          }
        }
      }
    }
    body = Poison.encode!(query)

    {:ok, response} = HTTPoison.post(url, body, headers)
    result = Poison.decode!(response.body)
    keys = result["aggregations"]["applications"]["buckets"]
    Enum.map(keys, fn(bucket) -> bucket["key"] end)
  end

  def handle_response({:ok, response}) do
    Poison.decode!(response.body)
  end

  def handle_response({:error, response}) do
    Poison.decode!(response.body)
  end
end
