defmodule Struct.Services.StreamCreate do
  def call(options) do
    channel_id   = options[:channel_id]
    title        = options[:title]
    description  = options[:description]
    user_id      = options[:user_id]
    now          = Ecto.DateTime.utc
    streamkey    = UUID.uuid4(:hex)

    %LiveStream{channel_id: channel_id, title: title, description: description, user_id: user_id, streamkey: streamkey, created_at: now} |>
    Repo.insert
  end


end