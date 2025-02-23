defmodule Blinks.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :title, :string
    field :url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :title])
    |> validate_required([:url, :title])
  end
end
