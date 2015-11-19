defmodule Struct.PageController do
  import Ecto.Query, only: [from: 2]
  use Phoenix.Controller
  plug :action

  def index(conn, _params) do
    token = get_session(conn, :auth_token)
    render conn, "index", auth_token: token
  end

  def not_found(conn, _params) do
    render conn, "not_found"
  end

  def error(conn, _params) do
    render conn, "error"
  end

 

end
