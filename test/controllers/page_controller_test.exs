defmodule Notifilter.PageControllerTest do
  use Notifilter.ConnCase

  test "show message about needing to login" do
    conn = get conn, page_path(conn, :require_auth)
    assert html_response(conn, 200) =~ "Login via Google"
  end
end
