defmodule PhxIconsDemoWeb.PageControllerTest do
  use PhxIconsDemoWeb.ConnCase

  import PhxIcons.Test

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    html = html_response(conn, 200)

    assert html =~ "PhxIcons"
    assert_icon html, "heroicons:heart"
    assert_icon html, "lucide:heart"
    assert_icon html, "tabler:heart"
    assert_icon html, "phosphor:heart"
  end
end
