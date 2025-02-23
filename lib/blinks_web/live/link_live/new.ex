defmodule BlinksWeb.LinkLive.New do
  alias Blinks.Links
  alias Blinks.Links.Link
  use BlinksWeb, :live_view

  def mount(_params, _session, socket) do
    changeset = Link.changeset(%Link{})

    socket =
      socket
      |> assign(:form, to_form(changeset))

    {:ok, socket}
  end

  def handle_event("submit", %{"link" => link_params}, socket) do
    case Links.create_link(link_params) do
      {:ok, _link} ->
        socket =
          socket
          |> put_flash(:info, "Link created successfully.")
          |> push_navigate(to: ~p"/links")

        {:noreply, socket}

      {:error, changeset} ->
        socket =
          socket
          |> assign(:form, to_form(changeset))

        {:noreply, socket}
    end
  end
end
