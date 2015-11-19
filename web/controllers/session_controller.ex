defmodule Struct.SessionController do
  use Phoenix.Controller
  alias Struct.Router
  plug :action
  
  def logout(conn, _params) do
    conn = delete_session(conn, :auth_token)
    redirect conn, "/"
  end
end
