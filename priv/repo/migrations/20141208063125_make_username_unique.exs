defmodule Repo.Migrations.MakeUsernameUnique do
  use Ecto.Migration

  def up do
    "CREATE UNIQUE INDEX unique_username ON users (username);"
  end

  def down do
    "DROP INDEX unique_username"
  end
end
