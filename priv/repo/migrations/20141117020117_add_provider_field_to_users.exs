defmodule Repo.Migrations.AddProviderFieldToUsers do
  use Ecto.Migration

  def up do
    "ALTER TABLE users ADD COLUMN oauth_provider varchar(255)"
  end

  def down do
    "ALTER TABLE users DROP COLUMN oauth_provider"
  end
end
