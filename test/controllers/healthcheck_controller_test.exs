defmodule Notifilter.HealthcheckControllerTest do
  use Notifilter.ConnCase, async: true

  test "requires authentication" do
    conn = get(build_conn(), healthcheck_path(build_conn(), :index))
    assert response(conn, 200)
  end
end
