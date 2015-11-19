defmodule Struct.Services.UserCreate do
  import Ecto.Query, only: [from: 2]
  
  def call(options) do
    
    username = options[:username]
    realname = options[:realname]
    avatar_url = options[:avatar_url]

    # Generate a unique username
    # Check if username is in use?

    query = from(u in User, where: u.username == ^(username), select: u, limit: 1)
    existing = Enum.at(Repo.all(query), 0)

    if existing != nil do
      username = "#{username}-#{UUID.uuid4(:hex)}"
      if String.length(username) > 40 do
        username = String.slice(username, 0, 40)
      end
    end

    u = %User{username: username, realname: realname,  avatar_url: avatar_url}
    user = Repo.insert(u)
  end
end

