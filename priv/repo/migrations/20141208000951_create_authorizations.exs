defmodule Repo.Migrations.CreateAuthorizations do
  use Ecto.Migration

  def up do
   "CREATE TABLE authorizations(id serial primary key, user_id int REFERENCES users, oauth_id varchar(255), oauth_provider varchar(255), oauth_token varchar(255), refresh_token varchar(255), expires_at timestamp with time zone, created_at timestamp with time zone DEFAULT now())"
  end

  def down do
    "DROP TABLE authorizations;"
  end
end
