defmodule Repo.Migrations.AddOauthFieldsToUsers do
  use Ecto.Migration

 def up do
    "ALTER TABLE users ADD COLUMN oauth_token varchar(255), ADD COLUMN oauth_id varchar(255), ADD COLUMN oauth_refresh_token varchar(255), ADD COLUMN oauth_expires_at timestamp with time zone"
  end

  def down do
    "ALTER TABLE users DROP COLUMN oauth_token, DROP COLUMN oauth_refresh_token, DROP COLUMN oauth_expires_at"
  end
end
