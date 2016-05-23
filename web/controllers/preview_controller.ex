defmodule Notifilter.PreviewController do
  @moduledoc false

  use Notifilter.Web, :controller

  alias Notifilter.Elasticsearch
  alias Notifilter.Previewer

  def preview(conn, params) do
    application = params["application"]
    event = params["event"]
    template = params["template"]

    data = Elasticsearch.event_by_name(application, event)
    result = Previewer.preview(data, template)
    render conn, "preview.json", result: result
  end
end
