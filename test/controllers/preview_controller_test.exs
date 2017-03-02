defmodule Notifilter.PreviewControllerTest do
  use Notifilter.ConnCase, async: true

  test "requires authentication" do
    conn = post build_conn(), preview_path(build_conn(), :preview), %{}
    assert html_response(conn, 302)
  end
end
