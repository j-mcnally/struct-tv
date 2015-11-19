defmodule Struct.Api.V1.MessagesChannel do
  use Phoenix.Channel

  def join(socket, topic, message) do
    {:ok, socket}
  end

  def join(socket, _no, _message) do
    {:error, socket, :unauthorized}
  end

end