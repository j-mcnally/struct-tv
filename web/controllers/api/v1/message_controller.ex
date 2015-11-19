defmodule Struct.Api.V1.MessageController do
  use Phoenix.Controller
  alias Poison, as: JSON
  plug Struct.AuthenticationPlug
  plug :action

  def create(conn, _params) do
    user = conn.assigns[:current_user]
    body = _params["message"]["body"]
    stream_id = _params["message"]["stream_id"]
    message = %{
      message: %{
        id: UUID.uuid4(:hex),
        sender: user.username,
        body: body
      }
    }
    if body != nil and body != "" do
      Phoenix.Channel.broadcast "messages", "#{stream_id}", "new:message", message    
      json conn, JSON.encode!(message)
    else
      json conn, 502, JSON.encode!(%{error: "Body cannot be blank"})
    end
  end

end
