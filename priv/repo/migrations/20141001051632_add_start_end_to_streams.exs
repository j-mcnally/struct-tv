defmodule Repo.Migrations.AddProfileFieldsToUsers do
  use Ecto.Migration

  def up do
    "ALTER TABLE streams ADD COLUMN started_at timestamp with time zone, ADD COLUMN ended_at timestamp with time zone"
  end

  def down do
    "ALTER TABLE streams DROP COLUMN started_at, DROP COLUMN ended_at"
  end
end
