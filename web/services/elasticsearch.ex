defmodule Notifilter.Elasticsearch do
  @moduledoc """
  Elasticsearch talks to the ES service and gives back latest events or specific
  events, all known fields and applications.
  """

  def status do
    host()
    |> HTTPoison.get([])
    |> handle_response
  end

  def latest_events(page) do
    url = "#{host()}/notifilter/event/_search"
    query = %{
      "size": 10,
      "from": page * 10,
      "sort": [
        %{
          "received_at": %{
            "order": "desc"
          }
        }
      ]
    }
    body = Poison.encode!(query)
    HTTPoison.post(url, body, [])
    |> handle_response
  end

  def latest_events_by_name(name, page) do
    url = "#{host()}/notifilter/event/_search"
    query = %{
      "size": 10,
      "from": page * 10,
      "query": %{
        "term": %{
          "name": name
        }
      },
      "sort": [
        %{
          "received_at": %{
            "order": "desc"
          }
        }
      ]
    }
    body = Poison.encode!(query)
    HTTPoison.post(url, body, [])
    |> handle_response
  end

  def event(event_id) do
    url = "#{host()}/notifilter/event/#{event_id}"
    {:ok, response} = HTTPoison.get(url, [])
    Poison.decode!(response.body)["_source"]
  end

  def event_by_name(application, name, offset) do
    url = "#{host()}/notifilter/event/_search"
    query = %{
      "size": 1,
      "from": offset,
      "query": %{
        "bool": %{
          "must": [
            %{
              "term": %{
                "application": application
              }
            },
            %{
              "term": %{
                "name": name
              }
            }
          ]
        }
      },
      "sort": [
        %{
          "received_at": %{
            "order": "desc"
          }
        }
      ]
    }
    body = Poison.encode!(query)
    IO.puts("Query:")
    IO.inspect(query)

    {:ok, response} = HTTPoison.post(url, body, [])
    result = Poison.decode!(response.body)["hits"]["hits"]
    Enum.at(result, 0)["_source"]["data"]
  end

  @doc """
  Return all known values of <field> we have seen so far.
  """
  def get_fields(field) do
    url = "#{host()}/notifilter/event/_search"
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
    url = "#{host()}/notifilter/event/_search"
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

  def get_event_keys do
    url = "#{host()}/notifilter/_mapping"
    {:ok, response} = HTTPoison.get(url, [])
    result = Poison.decode!(response.body)["notifilter"]["mappings"]["event"]["properties"]["data"]["properties"]
    Enum.sort(Map.keys(result))
  end

  defp handle_response({:ok, response}) do
    Poison.decode!(response.body)
  end

  defp handle_response({:error, response}) do
    Poison.decode!(response.body)
  end

  defp host() do
    Application.get_env(:notifilter, Elasticsearch)[:host]
  end
end
