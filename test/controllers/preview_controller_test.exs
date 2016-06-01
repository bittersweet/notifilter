defmodule Notifilter.PreviewControllerTest do
  use Notifilter.ConnCase

  test "requires authentication" do
    conn = post conn, preview_path(conn, :preview), %{}
    assert html_response(conn, 302)
  end
end
