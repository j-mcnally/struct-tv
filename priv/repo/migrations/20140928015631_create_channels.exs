defmodule Repo.Migrations.CreateChannels do
  use Ecto.Migration

    def up do
      "CREATE TABLE channels(id serial primary key, github_id int, title varchar(100), project_url varchar(255), description text, image varchar(255), popularity float(4), created_at timestamp with time zone DEFAULT now())"
    end

    def down do
      "DROP TABLE channels;"
    end
end
