defmodule BlinksWeb.OnlineUsersCounter do
  @moduledoc """
  This module provides functionality to track and count online users.
  """

  alias BlinksWeb.Presence
  require Logger

  @online_users_topic "online_users_topic"

  def online_users_topic, do: @online_users_topic

  def track_online_user do
    user_id = "user:#{Ecto.UUID.generate()}"

    case Presence.track(self(), @online_users_topic, user_id, %{}) do
      {:ok, ref} ->
        {:ok, ref}

      {:error, reason} ->
        Logger.warning("Failed to track online user: #{inspect(reason)}")
        reason
    end
  end

  def get_online_users_count do
    Presence.list(@online_users_topic)
    |> map_size()
  end
end
