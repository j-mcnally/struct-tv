defmodule Struct.Services.TokenFind do
  import Ecto.Query, only: [from: 2]
  
  def call(options) do
    user = options[:user]
    provider = options[:provider]

    query = from(a in Authorization, where: a.user_id == ^(user.id) and a.oauth_provider == ^(provider), select: a, limit: 1)
    auth = Enum.at(Repo.all(query), 0)
    
    if auth do
      if provider == "Meetup" do
        [auth, OAuth2Ex.Provider.Meetup.mk_token(auth.oauth_token, auth.refresh_token, auth.expires_at)]
      else
        if provider == "Github" do
          [auth, OAuth2Ex.Provider.Github.mk_token(auth.oauth_token)]
        end
      end
    else
      [nil, nil]
    end
  end


end

