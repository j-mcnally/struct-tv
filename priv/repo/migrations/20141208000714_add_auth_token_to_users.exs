defmodule Repo.Migrations.AddAuthTokenToUsers do
  use Ecto.Migration

  def up do
    "ALTER TABLE users ADD COLUMN auth_token varchar(255)"
  end

  def down do
    "ALTER TABLE users DROP COLUMN auth_token"
  end

end
