defmodule Blinks.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blinks.Links` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        url: "https://example.com"
      })
      |> Blinks.Links.create_link()

    link
  end
end
