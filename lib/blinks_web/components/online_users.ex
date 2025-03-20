defmodule BlinksWeb.OnlineUsers do
  @moduledoc """
  Component to show the count of online users.
  """
  use Phoenix.Component

  attr :count, :integer, required: true

  def online_users(assigns) do
    ~H"""
    <div class="flex items-center justify-between gap-2">
      <p>{@count} people online</p>
      <span class="relative flex top-0 right-0 size-2.5">
        <span class="absolute flex h-full w-full animate-ping rounded-full bg-green-300 opacity-75 [animation-duration:1.5s]">
        </span>
        <span class="relative inline-flex size-2.5 rounded-full bg-green-400"></span>
      </span>
    </div>
    """
  end
end
