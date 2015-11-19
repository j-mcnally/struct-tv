defmodule Struct.Oauth.MeetupController do
  use Timex

  import Ecto.Query, only: [from: 2]
  use Phoenix.Controller
  alias Struct.Router
  plug :action
  
  def meetup(conn, _params) do
    redirect conn, OAuth2Ex.Provider.Meetup.authorize_url
  end

  def meetup_code(conn, params) do
    code = params["code"]
    token = OAuth2Ex.Provider.Meetup.get_token(code)
    refresh_token = token.refresh_token
    user_info = OAuth2Ex.Provider.Meetup.me(token)

    img = (user_info["photo"] || %{})["photo_link"] || ""
    {expires_in, _} = Integer.parse("#{Float.floor(token.expires_in / 100, 0)}")
    expiry = Date.convert(Date.universal(), :secs) + expires_in - 1000 
    epoc = :calendar.datetime_to_gregorian_seconds({{1970,1,1},{0,0,0}})
    expiry = Ecto.DateTime.from_erl(:calendar.gregorian_seconds_to_datetime(epoc + expiry))

    username = String.replace(String.downcase(user_info["name"]), ~r/\W/, "")

    user = Struct.Services.AuthorizationCreate.call(user_info_id: "#{user_info["id"]}", avatar_url: img, user_name: username, realname: user_info["name"], token: token, refresh_token: refresh_token, expiry: expiry, provider: "Meetup")
    conn = put_session(conn, :auth_token, User.get_auth_token(user))
    redirect conn, "/" 


  end
end