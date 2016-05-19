defmodule Notifilter.LayoutView do
  @moduledoc false

  use Notifilter.Web, :view

  def signed_in?(conn) do
    conn.assigns.current_user
  end
end
