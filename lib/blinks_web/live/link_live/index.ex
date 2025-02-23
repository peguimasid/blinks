defmodule BlinksWeb.LinkLive.Index do
  use BlinksWeb, :live_view

  alias Blinks.Links

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:links, Links.list_links())

    {:ok, socket}
  end
end
