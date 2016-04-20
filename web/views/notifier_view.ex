defmodule Notifilter.NotifierView do
  use Notifilter.Web, :view

  def render("update.json", _params) do
    %{status: 200}
  end
end
