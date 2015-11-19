defmodule Repo.Migrations.CreateUsers do
  use Ecto.Migration

    def up do
      "CREATE TABLE users(id serial primary key, username varchar(40), realname varchar(100))"
    end

    def down do
      "DROP TABLE users"
    end
end
