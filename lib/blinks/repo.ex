defmodule Blinks.Repo do
  use Ecto.Repo,
    otp_app: :blinks,
    adapter: Ecto.Adapters.Postgres
end
