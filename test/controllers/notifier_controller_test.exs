defmodule Notifilter.NotifierControllerTest do
  use Notifilter.ConnCase, async: true

  def insert_notifier(attrs \\ %{}) do
    changes = Map.merge(%{
      application: "Application 1",
      event_name: "conversion",
      template: "New conversion by user",
      rules: [%{}],
      notification_type: "slack",
      target: "#test",
    }, attrs)

    %Notifilter.Notifier{}
    |> Notifilter.Notifier.changeset(changes)
    |> Repo.insert!
  end

  test "redirects to auth" do
    conn = get build_conn(), "/"
    assert html_response(conn, 302)
  end

  test "shows notifiers when logged in" do
    insert_notifier(%{application: "Notifilter Testapp"})

    user = %{name: "mark", avatar: "", email: "mark@springest.com"}
    conn = assign(build_conn(), :current_user, user)
    conn = get conn, notifier_path(conn, :index)
    assert html_response(conn, 200) =~ "Notifilter Testapp"
  end
end
