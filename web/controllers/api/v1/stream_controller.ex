defmodule Struct.Api.V1.StreamController do
  use Phoenix.Controller
  alias Poison, as: JSON
  import Ecto.Query, only: [from: 2]
  plug Struct.AuthenticationPlug, only: [:create, :update]
  plug :action
  
  def index(conn, _params) do
    if _params["following"] do
      conn = Struct.AuthenticationPlug.call(conn)
    else if _params["popular"] do
      streams = Struct.Services.StreamPopular.call()
      compiled = Struct.Services.StreamJsonList.call(streams: streams)
      json conn, JSON.encode!(compiled)
    end


  end


  end

  def show(conn, _params) do

    if _params["id"] == "featured" do
      stream = Struct.Services.StreamFeatured.call()
    else
      stream = Struct.Services.StreamFind.call(id: _params["id"])
      recordings = Struct.Services.StreamRecordingsFind.call(stream: stream)
    end

    if stream do
      stream_json = Struct.Services.StreamJsonCreate.call(stream: stream, recordings: recordings, include_key: false)
      json conn, JSON.encode!(stream_json)
    else
      json conn, 404, JSON.encode!(%{error: "404 Stream not found"})
    end

  end

  def update(conn, _params) do
    user = conn.assigns[:current_user]
    id = _params["id"]
    user_id = "#{user.id}"
    stream = Struct.Services.StreamFind.call(id: id, user_id: user_id)
    if stream do
      stream_params = _params["stream"]
      stream = %{stream | title: stream_params["title"], description: stream_params["description"] }
      Repo.update(stream)
      stream_json = Struct.Services.StreamJsonCreate.call(stream: stream)
      Phoenix.Channel.broadcast "streams", "#{stream.id}", "update:stream", %{stream: LiveStream.to_struct(stream, false)}

      json conn, JSON.encode!(stream_json)
    else
      json conn, 404, JSON.encode!(%{error: "Stream not found."})
    end
  end

  def create(conn, _params) do
    user = conn.assigns[:current_user]
    stream_params = _params["stream"]
    [auth, oauth_token] = Struct.Services.TokenFind.call(user: user, provider: stream_params["ext_provider"])
    channel = Struct.Services.ChannelCreate.call(oauth_token: oauth_token, ext_id: stream_params["ext_id"], ext_provider: stream_params["ext_provider"])
    stream  = Struct.Services.StreamCreate.call(title: stream_params["title"], description: stream_params["description"], channel_id: channel.id, user_id: user.id)    
    stream_json = Struct.Services.StreamJsonCreate.call(stream: stream, channel: channel, user: user, include_key: true)

    json conn, JSON.encode!(stream_json)
  end

end
