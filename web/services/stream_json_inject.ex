defmodule Struct.Services.StreamJsonInject do
  import Ecto.Query, only: [from: 2]

  def call(options) do
    stream = options[:stream]
    include_key = options[:include_key] || false
    inject = options[:inject] || %{}
    if stream, do: inject = Map.put(inject, :streams, [LiveStream.to_struct(stream, include_key)])
    if stream, do: inject = Map.put(inject, :channels, [Channel.to_struct(stream.channel.get)])
    inject
  end

end