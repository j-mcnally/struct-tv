defmodule Struct.Services.AuthorizationCreate do
  import Ecto.Query, only: [from: 2]

  def call(options) do
    user  = options[:user]
    token = options[:token]
    user_info_id = options[:user_info_id]
    provider = options[:provider]
    refresh_token = options[:refresh_token] || nil
    refresh_expiry = options[:expiry] || nil
    user_name = options[:user_name]
    avatar_url = options[:avatar_url]
    realname = options[:realname]

    query = from(a in Authorization, preload: [:user], where: a.oauth_id == ^(user_info_id) and a.oauth_provider == ^(provider), select: a)

    results = Repo.all(query)
    # Does an authorization exist?
    if length(results) > 0 do
      # Update the authroization? Makes sense to have most recent credentials
      auth = hd(results)
      user = auth.user.get
      auth = %{auth | oauth_token: token.access_token, oauth_provider: provider, oauth_id: user_info_id, refresh_token: refresh_token, expires_at: refresh_expiry }
      Repo.update(auth)
    else
      # No existing auth record
      # Does a user exist?
      if user == nil do
        # Create a user based on auth info
        user = Struct.Services.UserCreate.call(username: user_name, realname: realname, avatar_url: avatar_url)
      end

      auth = %Authorization{user_id: user.id, oauth_token: token.access_token, oauth_provider: provider, oauth_id: user_info_id, refresh_token: refresh_token, expires_at: refresh_expiry }
      auth = Repo.insert(auth)
    end
    user
  end

end