defmodule Repo.Migrations.AddViewerFieldsToStreams do
  use Ecto.Migration

  def up do
    "ALTER TABLE streams ADD COLUMN viewers_current int, ADD COLUMN viewers_total int"
  end

  def down do
    "ALTER TABLE streams DROP COLUMN viewers_current, DROP COLUMN viewers_total"
  end
end
