defmodule BlinksWeb.LinkLive.Index do
  alias Phoenix.PubSub
  alias Blinks.Links.Link
  use BlinksWeb, :live_view

  alias Blinks.Links

  @topic "links"

  def mount(_params, _session, socket) do
    PubSub.subscribe(Blinks.PubSub, @topic)

    socket =
      socket
      |> assign(:links, Links.list_links())
      |> assign(:form, to_form(Link.changeset(%Link{})))

    {:ok, socket}
  end

  def handle_event("submit", %{"link" => link_params}, socket) do
    case Links.create_link(link_params) do
      {:ok, link} ->
        PubSub.broadcast(Blinks.PubSub, @topic, {:new_link, link})

        changeset = Link.changeset(%Link{url: ""})

        socket =
          socket
          |> put_flash(:info, "Link created successfully.")
          |> assign(:form, to_form(changeset))

        {:noreply, socket}

      {:error, changeset} ->
        socket =
          socket
          |> assign(:form, to_form(changeset))

        {:noreply, socket}
    end
  end

  def handle_info({:new_link, link}, socket) do
    socket =
      socket
      |> assign(:links, socket.assigns.links ++ [link])

    {:noreply, socket}
  end
end
