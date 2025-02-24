defmodule BlinksWeb.OnlineUsers do
  @moduledoc """
  Component to show the count of online users.
  """
  use Phoenix.Component

  attr :count, :integer, required: true

  def show_online_users(assigns) do
    ~H"""
    <p class="rounded-lg bg-zinc-100 px-2 py-1 hover:bg-zinc-200/80">
      {@count} people online
    </p>
    """
  end
end
