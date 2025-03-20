defmodule BlinksWeb.LinkLive.Index do
  alias BlinksWeb.OnlineUsersCounter
  alias Phoenix.PubSub
  alias Blinks.Links.Link
  use BlinksWeb, :live_view

  alias Blinks.Links

  @topic "links"

  def mount(_params, _session, socket) do
    if connected?(socket) do
      PubSub.subscribe(Blinks.PubSub, @topic)
      PubSub.subscribe(Blinks.PubSub, OnlineUsersCounter.online_users_topic())
      OnlineUsersCounter.track_online_user()
    end

    socket =
      socket
      |> assign(:links, Links.list_links())
      |> assign(:form, to_form(Link.changeset(%Link{})))
      |> assign(:online_users_count, 0)

    {:ok, socket}
  end

  def handle_event("validate", %{"link" => params}, socket) do
    form =
      %Link{}
      |> Links.change_link(params)
      |> to_form(action: :validate)

    socket =
      socket
      |> assign(:form, form)

    {:noreply, socket}
  end

  def handle_event("create", %{"link" => link_params}, socket) do
    case Links.create_link(link_params) do
      {:ok, link} ->
        PubSub.broadcast(Blinks.PubSub, @topic, {:new_link, link})

        changeset = Link.changeset(%Link{})

        socket =
          socket
          |> put_flash(:info, "Link created successfully.")
          |> assign(:form, to_form(changeset))

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket =
          socket
          |> assign(:form, to_form(changeset))

        {:noreply, socket}
    end
  end

  def handle_event("delete", %{"id" => id}, socket) do
    link = Links.get_link!(id)

    case Links.delete_link(link) do
      {:ok, _link} ->
        PubSub.broadcast(Blinks.PubSub, @topic, {:delete_link, link})

        socket =
          socket
          |> put_flash(:info, "Link deleted successfully.")

        {:noreply, socket}

      {:error, _reason} ->
        socket =
          socket
          |> put_flash(:error, "Failed to delete link.")

        {:noreply, socket}
    end
  end

  def handle_info({:new_link, link}, socket) do
    socket =
      socket
      |> assign(:links, socket.assigns.links ++ [link])

    {:noreply, socket}
  end

  def handle_info({:delete_link, link}, socket) do
    updated_links = List.delete(socket.assigns.links, link)

    socket =
      socket
      |> assign(:links, updated_links)

    {:noreply, socket}
  end

  def handle_info(%Phoenix.Socket.Broadcast{} = _event, socket) do
    socket =
      socket
      |> assign(:online_users_count, OnlineUsersCounter.get_online_users_count())

    {:noreply, socket}
  end
end
