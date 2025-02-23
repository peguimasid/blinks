defmodule BlinksWeb.LinkLive.Index do
  alias Blinks.Links.Link
  use BlinksWeb, :live_view

  alias Blinks.Links

  def mount(_params, _session, socket) do
    changeset = Link.changeset(%Link{})

    socket =
      socket
      |> assign(:links, Links.list_links())
      |> assign(:form, to_form(changeset))

    {:ok, socket}
  end

  def handle_event("submit", %{"link" => link_params}, socket) do
    case Links.create_link(link_params) do
      {:ok, link} ->
        socket =
          socket
          |> put_flash(:info, "Link created successfully.")
          |> assign(:links, socket.assigns.links ++ [link])
          |> assign(:form, to_form(Link.changeset(%Link{})))

        {:noreply, socket}

      {:error, changeset} ->
        socket =
          socket
          |> assign(:form, to_form(changeset))

        {:noreply, socket}
    end
  end
end
