defmodule Struct.Api.V1.ChannelController do
  use Phoenix.Controller
  import Ecto.Query, only: [from: 2]
  alias Poison, as: JSON
  
  plug Struct.AuthenticationPlug
  plug :action

  def index(conn, _params) do

    json conn, JSON.encode!()
  end

  def show(conn, _params) do
    
    json conn, JSON.encode!()
  end

end
