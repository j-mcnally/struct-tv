defmodule Repo.Migrations.AddGithubTokenAndSecretToUsers do
  use Ecto.Migration

  def up do
    "ALTER TABLE users ADD COLUMN github_token varchar(100)"
  end

  def down do
    "ALTER TABLE users DROP COLUMN github_token"
  end
end
