defmodule BlinksWeb.Presence do
  use Phoenix.Presence,
    otp_app: :blinks,
    pubsub_server: Blinks.PubSub
end
