defmodule Repo.Migrations.AddFeaturedAtToStreams do
  use Ecto.Migration

  def up do
    "ALTER TABLE streams ADD COLUMN featured_at timestamp with time zone"
  end

  def down do
    "ALTER TABLE streams DROP COLUMN featured_at"
  end
end
