defmodule BlinksWeb.PageController do
  use BlinksWeb, :controller

  def index(conn, _params) do
    conn
    |> redirect(to: "/links")
  end
end
