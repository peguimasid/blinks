defmodule BlinksWeb.PageControllerTest do
  use BlinksWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert redirected_to(conn) == "/links"
  end
end
