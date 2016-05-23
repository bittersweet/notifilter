defmodule Notifilter.PreviewView do
  @moduledoc false

  use Notifilter.Web, :view

  def render("preview.json", params) do
    %{status: 200, result: params[:result]}
  end
end
