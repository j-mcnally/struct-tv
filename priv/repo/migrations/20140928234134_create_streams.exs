defmodule Repo.Migrations.CreateStreams do
  use Ecto.Migration

    def up do
      "CREATE TABLE streams(id serial primary key, user_id int REFERENCES users, channel_id int REFERENCES channels, title varchar(100), description text, streamkey varchar(255) UNIQUE, created_at timestamp with time zone DEFAULT now())"
    end

    def down do
      "DROP TABLE streams;"
    end
end
