defmodule Notifilter.EventControllerTest do
  use Notifilter.ConnCase

  test "requires authentication" do
    conn = get conn, event_path(conn, :index)
    assert html_response(conn, 302)
  end
end
