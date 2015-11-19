defmodule Repo.Migrations.AddGithubFieldsToUser do
  use Ecto.Migration

  def up do
    "ALTER TABLE users ADD COLUMN github_username varchar(40), ADD COLUMN github_id varchar(40), ADD COLUMN company varchar(120), ADD COLUMN avatar_url varchar(255);"
  end

  def down do
    "ALTER TABLE users DROP COLUMN github_username, DROP COLUMN github_id, DROP COLUMN company, DROP COLUMN avatar_url;"
  end
end
