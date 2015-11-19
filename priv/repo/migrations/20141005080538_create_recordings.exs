defmodule Repo.Migrations.CreateRecordings do
  use Ecto.Migration

  def up do
    "CREATE TABLE recordings(id serial primary key, stream_id int REFERENCES streams, path varchar(255), created_at timestamp with time zone DEFAULT now())"
  end

  def down do
    "DROP TABLE recordings;"
  end
end
