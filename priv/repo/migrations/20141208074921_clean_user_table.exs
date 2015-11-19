defmodule Repo.Migrations.CleanUserTable do
  use Ecto.Migration

  def up do
    "ALTER TABLE users DROP COLUMN github_username, DROP COLUMN github_id, DROP COLUMN github_token, DROP COLUMN oauth_token, DROP COLUMN oauth_id, DROP COLUMN oauth_refresh_token, DROP COLUMN oauth_expires_at, DROP COLUMN oauth_provider"
  end

  def down do
    ""
  end
end
