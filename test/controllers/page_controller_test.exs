defmodule Notifilter.PageControllerTest do
  use Notifilter.ConnCase, async: true

  test "show message about needing to login" do
    conn = get build_conn(), page_path(build_conn(), :require_auth)
    assert html_response(conn, 200) =~ "Login via Google"
  end
end
