defmodule Struct.Services.StreamStart do
  def call(options) do
    stream = options[:stream]
    # Mark stream started
    if !stream.started_at do
      stream = %{stream | started_at: Ecto.DateTime.utc}
    end
    stream = %{stream | ended_at: nil}
    msg = %{stream: %{id: stream.id, started_at: stream.started_at, ended_at: stream.ended_at}}
    Phoenix.Channel.broadcast "streams", "#{stream.id}", "start:stream", msg  
    Repo.update(stream)
  end
end