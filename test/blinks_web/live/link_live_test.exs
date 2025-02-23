defmodule BlinksWeb.LinkLiveTest do
  use BlinksWeb.ConnCase

  import Phoenix.LiveViewTest
  import Blinks.LinksFixtures

  @create_attrs %{url: "https://some_url.com"}
  # @update_attrs %{url: "https://some_updated_url.com"}
  @invalid_attrs %{url: nil}

  defp create_link(_) do
    link = link_fixture()
    %{link: link}
  end

  describe "Index" do
    setup [:create_link]

    test "lists all links", %{conn: conn, link: _link} do
      {:ok, _index_live, html} = live(conn, ~p"/links")

      assert html =~ "Links"
    end

    test "saves new link", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/links")

      assert index_live
             |> element("a", "Add link")
             |> render_click() =~ "New Link"

      assert_patch(index_live, ~p"/links/new")

      assert index_live
             |> form("#link-form", link: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#link-form", link: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/links")

      html = render(index_live)
      assert html =~ "Link created successfully"
    end

    # test "updates link in listing", %{conn: conn, link: link} do
    #   {:ok, index_live, _html} = live(conn, ~p"/links")

    #   assert index_live |> element("#links-#{link.id} a", "Edit") |> render_click() =~
    #            "Edit Link"

    #   assert_patch(index_live, ~p"/links/#{link}/edit")

    #   assert index_live
    #          |> form("#link-form", link: @invalid_attrs)
    #          |> render_change() =~ "can&#39;t be blank"

    #   assert index_live
    #          |> form("#link-form", link: @update_attrs)
    #          |> render_submit()

    #   assert_patch(index_live, ~p"/links")

    #   html = render(index_live)
    #   assert html =~ "Link updated successfully"
    # end

    # test "deletes link in listing", %{conn: conn, link: link} do
    #   {:ok, index_live, _html} = live(conn, ~p"/links")

    #   assert index_live |> element("#links-#{link.id} a", "Delete") |> render_click()
    #   refute has_element?(index_live, "#links-#{link.id}")
    # end
  end
end
