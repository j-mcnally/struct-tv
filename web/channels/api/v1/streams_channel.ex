defmodule Struct.Api.V1.StreamsChannel do
  require Logger
  use Phoenix.Channel


  def join(socket, topic, message) do
    stream = Struct.Services.StreamFind.call(id: topic)
    Struct.Services.ViewerJoin.call(stream: stream)
    {:ok, socket}
  end
  
  def join(socket, _no, _message) do
    {:error, socket, :unauthorized}
  end

  def leave(socket, message) do
    stream_ids = for c <- socket.channels do 
      {_, topic} = c
      stream = Struct.Services.StreamFind.call(id: topic)
      Struct.Services.ViewerLeave.call(stream: stream)
    end
    socket
  end



end