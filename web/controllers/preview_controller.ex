defmodule Notifilter.PreviewController do
  @moduledoc false

  use Notifilter.Web, :controller

  alias Notifilter.Elasticsearch
  alias Notifilter.Previewer

  def preview(conn, params) do
    application = params["application"]
    event = params["event"]
    template = params["template"]
    offset = params["offset"]

    data = Elasticsearch.event_by_name(application, event, offset)
    result = Previewer.preview(data, template)
    render conn, "preview.json", result: result
  end
end
