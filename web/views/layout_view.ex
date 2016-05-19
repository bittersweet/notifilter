defmodule Notifilter.LayoutView do
  use Notifilter.Web, :view

  def signed_in?(conn) do
    conn.assigns.current_user
  end
end
