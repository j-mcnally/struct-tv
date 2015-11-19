defmodule Repo.Migrations.AddExtFieldsToChannels do
  use Ecto.Migration

  def up do
    "ALTER TABLE channels ADD COLUMN ext_id int, ADD COLUMN ext_provider varchar(255)"
  end

  def down do
    "ALTER TABLE channels DROP COLUMN ext_id, DROP COLUMN ext_provider"
  end
end
