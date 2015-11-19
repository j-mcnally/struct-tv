defmodule Struct.Services.ViewerJoin do
  import Ecto.Query, only: [from: 2]

  def call(options) do
    stream = options[:stream]
    # increment viewers
    total = (stream.viewers_total || 0) + 1
    current = (stream.viewers_current || 0) + 1
    Phoenix.Channel.broadcast "streams", "#{stream.id}", "viewer_change:stream", %{stream: %{ viewers_total: total, viewers_current: current }}
    %{stream | viewers_total: total, viewers_current: current} |>
    Repo.update
  end

end