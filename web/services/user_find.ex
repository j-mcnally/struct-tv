defmodule Struct.Services.UserFind do
  import Ecto.Query, only: [from: 2]
  
  def call(options) do
    id = options[:id]
    if id, do: query = from(u in User, where: u.username == ^(id), select: u, limit: 1)
    Enum.at(Repo.all(query), 0)
  end
end

