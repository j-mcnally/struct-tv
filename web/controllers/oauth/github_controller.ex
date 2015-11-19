defmodule Struct.Oauth.GithubController do
  import Ecto.Query, only: [from: 2]
  use Phoenix.Controller
  alias Struct.Router
  plug :action
  
  def github(conn, _params) do
    redirect conn, OAuth2Ex.Provider.Github.authorize_url
  end

  def github_code(conn, %{"code" => code}) do
    token = OAuth2Ex.Provider.Github.get_token(code)
    user_info = OAuth2Ex.Provider.Github.me(token)
    avatar_url = user_info["avatar_url"] || ""
    user_info_id = Integer.to_string(user_info["id"])

    user = Struct.Services.AuthorizationCreate.call(user_info_id: user_info_id, avatar_url: avatar_url, user_name: user_info["login"], realname: user_info["name"], token: token, provider: "Github")
    conn = put_session(conn, :auth_token, User.get_auth_token(user))
    redirect conn, "/" 
  end
end