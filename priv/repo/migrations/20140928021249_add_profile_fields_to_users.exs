defmodule Repo.Migrations.AddProfileFieldsToUsers do
  use Ecto.Migration

  def up do
    "ALTER TABLE users ADD COLUMN email varchar(140), ADD COLUMN profile text, ADD COLUMN github_url varchar(255), ADD COLUMN premium bool, ADD COLUMN admin bool, ADD COLUMN created_at timestamp with time zone DEFAULT now()"
  end

  def down do
    "ALTER TABLE users DROP COLUMN email, DROP COLUMN profile, DROP COLUMN github_url, DROP COLUMN premium, DROP COLUMN admin, DROP COLUMN created_at"
  end
end
