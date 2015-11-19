defmodule Struct.Services.StreamJsonCreate do
  import Ecto.Query, only: [from: 2]

  def call(options) do
    stream = options[:stream]
    recordings = options[:recordings]
    channel = options[:channel] || stream.channel.get
    user  = options[:user] || stream.user.get
    include_key = options[:include_key] || false
    stream_struct = LiveStream.to_struct(stream, include_key)
    stream_s = %{stream_struct | full: true}
    
    json = %{
        stream: stream_s,
      channels: [Channel.to_struct(channel)],
         users: [User.to_struct(user)]
    }

    if recordings do
      recordings_s = for r <- recordings, do: Recording.to_struct(r)
      recording_ids = for r <- recordings, do: r.id
      json = %{json | stream: Map.put(json[:stream], :recordings, recording_ids) }
      json = Map.put(json, :recordings, recordings_s)

    end
    json
  end

end