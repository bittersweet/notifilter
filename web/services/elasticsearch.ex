defmodule Notifilter.Elasticsearch do
  @moduledoc """
  Elasticsearch talks to the ES service and gives back latest events or specific
  events, all known fields and applications.
  """

  def status do
    headers = [{"Content-type", "application/json"}]
    host()
    |> HTTPoison.get(headers)
    |> handle_response
  end

  def latest_events(page) do
    url = "#{host()}/notifilter/event/_search"

    query = %{
      size: 10,
      from: page * 10,
      sort: [
        %{
          received_at: %{
            order: "desc"
          }
        }
      ]
    }

    body = Poison.encode!(query)

    headers = [{"Content-type", "application/json"}]
    HTTPoison.post(url, body, headers)
    |> handle_response
  end

  def latest_events_by_name(name, page) do
    url = "#{host()}/notifilter/event/_search"

    query = %{
      size: 10,
      from: page * 10,
      query: %{
        term: %{
          name: name
        }
      },
      sort: [
        %{
          received_at: %{
            order: "desc"
          }
        }
      ]
    }

    body = Poison.encode!(query)

    headers = [{"Content-type", "application/json"}]
    HTTPoison.post(url, body, headers)
    |> handle_response
  end

  def event(event_id) do
    url = "#{host()}/notifilter/event/#{event_id}"
    headers = [{"Content-type", "application/json"}]
    {:ok, response} = HTTPoison.get(url, headers)
    Poison.decode!(response.body)["_source"]
  end

  def event_by_name(application, name, offset) do
    url = "#{host()}/notifilter/event/_search"

    query = %{
      size: 1,
      from: offset,
      query: %{
        bool: %{
          must: [
            %{
              term: %{
                application: application
              }
            },
            %{
              term: %{
                name: name
              }
            }
          ]
        }
      },
      sort: [
        %{
          received_at: %{
            order: "desc"
          }
        }
      ]
    }

    body = Poison.encode!(query)

    headers = [{"Content-type", "application/json"}]
    {:ok, response} = HTTPoison.post(url, body, headers)
    result = Poison.decode!(response.body)["hits"]["hits"]
    Enum.at(result, 0)["_source"]["data"]
  end

  @doc """
  Return all known values of <field> we have seen so far.
  """
  def get_fields(field) do
    url = "#{host()}/notifilter/event/_search"

    query = %{
      size: 0,
      aggs: %{
        field: %{
          terms: %{
            field: field,
            # Make sure we get all results, not limited
            # ES changed the option of setting size to 0, so I'm using a
            # "large" number for now.
            size: 1000,
            order: %{
              _term: "asc"
            }
          }
        }
      }
    }

    body = Poison.encode!(query)
    headers = [{"Content-type", "application/json"}]
    {:ok, response} = HTTPoison.post(url, body, headers)
    result = Poison.decode!(response.body)
    keys = result["aggregations"]["field"]["buckets"]
    Enum.map(keys, fn bucket -> bucket["key"] end)
  end

  def applications do
    url = "#{host()}/notifilter/event/_search"

    query = %{
      size: 0,
      aggs: %{
        applications: %{
          terms: %{
            field: "application",
            # Make sure we get all results, not limited
            size: 0,
            order: %{
              _term: "asc"
            }
          }
        }
      }
    }

    body = Poison.encode!(query)

    headers = [{"Content-type", "application/json"}]
    {:ok, response} = HTTPoison.post(url, body, headers)
    result = Poison.decode!(response.body)
    keys = result["aggregations"]["applications"]["buckets"]
    Enum.map(keys, fn bucket -> bucket["key"] end)
  end

  def get_event_keys do
    url = "#{host()}/notifilter/_mapping"
    headers = [{"Content-type", "application/json"}]
    {:ok, response} = HTTPoison.get(url, headers)

    result =
      Poison.decode!(response.body)["notifilter"]["mappings"]["event"]["properties"]["data"][
        "properties"
      ]

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
