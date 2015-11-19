defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    # The scheme can be anything, "ecto" is just an example
    parse_url System.get_env("DATABASE_URL")
  end

  def priv do
    app_dir(:struct, "priv/repo")
  end
end