defmodule Struct.Api.V1.UserController do
  use Phoenix.Controller
  alias Poison, as: JSON
  import Ecto.Query, only: [from: 2]
  plug Struct.AuthenticationPlug
  plug :action
  
  def update(conn, _params) do
    user = conn.assigns[:current_user]
    if user do
      user_params = _params["user"]
      user = %{user | username: user_params["username"], email: user_params["email"], profile: user_params["profile"] }
      Repo.update(user)
      user_json = Struct.Services.UserJsonCreate.call(user: user)
      # Phoenix.Channel.broadcast "users", "#{user.id}", "update:user", %{user: User.to_struct(user)}

      json conn, JSON.encode!(user_json)
    else
      json conn, 404, JSON.encode!(%{error: "User not found."})
    end
  end


  def show(conn, _params) do
    isme = false
    current_user = conn.assigns[:current_user]
    if (_params["id"] == "~me") || (_params["id"] == "#{current_user.id}") do
      user = current_user
      isme = true
    else
      query = from(u in User, where: u.username == ^(_params["id"]), select: u, limit: 1)
      [user] = Repo.all(query)
    end

    user_json = Struct.Services.UserJsonCreate.call(user: user, include_key: isme)
    
    json conn, JSON.encode!(user_json)
  end

end
