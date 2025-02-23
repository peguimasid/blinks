defmodule Blinks.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :text
      add :title, :text

      timestamps(type: :utc_datetime)
    end
  end
end
