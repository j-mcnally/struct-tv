defmodule Struct.Services.StreamRecord do
  def call(options) do
    stream = options[:stream]
    path = options[:path]
    %Recording{stream_id: stream.id, path: path} |>
    Repo.insert
  end
end