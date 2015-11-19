defmodule Struct.Services.StreamStop do
  def call(options) do
    stream = options[:stream]
    # Mark stream stopped
    stream = %{stream | ended_at: Ecto.DateTime.utc}
    msg = %{stream: %{id: stream.id, started_at: stream.started_at, ended_at: stream.ended_at}}
    Phoenix.Channel.broadcast "streams", "#{stream.id}", "stop:stream", msg
    Repo.update(stream)
  end
end