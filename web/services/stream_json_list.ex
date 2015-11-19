defmodule Struct.Services.StreamJsonList do
  import Ecto.Query, only: [from: 2]

  def call(options) do
    streams = options[:streams]
    
    # Load Required Users
    user_ids = for u <- streams, do: u.user_id
    query = from(u in User, select: u, where: u.id in array(^user_ids, :integer))
    users = Repo.all(query)
    # Load Required Channels
    channel_ids = for c <- streams, do: c.channel_id
    query = from(c in Channel, select: c, where: c.id in array(^channel_ids, :integer))
    channels = Repo.all(query)
    
    streams_s = for s <- streams, do: LiveStream.to_struct(s, false)
    users_s = for u <- users, do: User.to_struct(u)
    channels_s = for c <- channels, do: Channel.to_struct(c)

    %{
      streams: streams_s,
      users: users_s,
      channels: channels_s
    }

  end

end