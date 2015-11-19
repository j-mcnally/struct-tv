defmodule Struct.Services.StreamFind do
  import Ecto.Query, only: [from: 2, where: 3]

  def call(options) do
    stream_key = options[:stream_key]
    user       = options[:user]
    user_id    = options[:user_id]
    id         = options[:id]
    
    if user do
      stream = User.current_stream(user)
    else
      if id do
        {id, _} = Integer.parse(id)
        if user_id, do: {user_id, _} = Integer.parse(user_id)
        if id, do: query = from(s in LiveStream, where: s.id == ^(id), select: s, preload: [:channel, :user], limit: 1)
        if user_id, do: query = where(query, [s], s.user_id == ^(user_id))
        result = Repo.all(query)
        Enum.at(result, 0)
      end
    end

  end
end