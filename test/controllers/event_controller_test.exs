defmodule Notifilter.EventControllerTest do
  use Notifilter.ConnCase, async: true

  test "requires authentication" do
    conn = get build_conn(), event_path(build_conn(), :index)
    assert html_response(conn, 302)
  end
end
