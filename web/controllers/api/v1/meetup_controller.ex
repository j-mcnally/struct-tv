defmodule Struct.Api.V1.MeetupController do
  use Phoenix.Controller
  alias Poison, as: JSON
  alias OAuth2Ex.Provider.Meetup, as: Meetup
  plug Struct.AuthenticationPlug
  plug :action
  
  def index(conn, _params) do
    user = conn.assigns[:current_user]
    [auth, oauth_token] = Struct.Services.TokenFind.call(user: user, provider: "Meetup")
    if oauth_token do
      
      groups = Meetup.groups(oauth_token, auth.oauth_id)["results"]
      groups = for g <- groups do
        img = g["group_photo"] || %{}
        %{
          id: g["id"],
          name: g["name"],
          description: g["description"],
          link: g["link"],
          image: img["photo_link"]
        }
      end

      json conn, JSON.encode!(%{meetups: groups})
    else
      # TODO: Do we want to throw an error here? 401/404?
      json conn, "[]"
    end
  end

end
