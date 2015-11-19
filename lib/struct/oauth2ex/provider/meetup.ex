defmodule OAuth2Ex.Provider.Meetup do
  require Logger
  @moduledoc """
  Provider for Meetup OAuth 2.0 API.

  API: http://www.meetup.com/meetup_api/docs/
  """

  defmodule Client do
    @moduledoc """
    Client configuration for specifying required parameters
    for accessing OAuth 2.0 server.
    """

    use OAuth2Ex.Client

    def config do
      {:ok, callback} = Keyword.fetch(Application.get_env(:phoenix, Struct.Router), :oauth_callback)
      OAuth2Ex.config(
        id:            System.get_env("MEETUP_CLIENT_ID"),
        secret:        System.get_env("MEETUP_CLIENT_SECRET"),
        authorize_url: "https://secure.meetup.com/oauth2/authorize",
        token_url:     "https://secure.meetup.com/oauth2/access",
        scope:         "ageless basic",
        callback_url:  "#{callback}/oauth/meetup/code"
      )
    end

    def get_token(code) do
      OAuth2Ex.get_token(config, code)
    end

    def refresh_token(token) do
      OAuth2Ex.refresh_token(config, token, [force: true])
    end

    def auth_url do
      OAuth2Ex.get_authorize_url(config)
    end

  end

  @doc """
  Retrieve the OAuth token from the server, and store to the file
  in the specified token_store path.
  """
  def authorize_url do
    # Get authentication parameters.
    Client.auth_url
  end

  def get_token(code) do
    Client.get_token(code)
  end

  def refresh_token(token) do
    Client.refresh_token(token)
  end

  def mk_token(auth_token, my_refresh_token, expires_at) do
    
    sec_expires_at = :calendar.datetime_to_gregorian_seconds(Ecto.DateTime.to_erl(expires_at))
    sec_now = :calendar.datetime_to_gregorian_seconds(Ecto.DateTime.to_erl(Ecto.DateTime.utc))

    if sec_now >= sec_expires_at do
      # Refresh the token.
      new_token = refresh_token(%OAuth2Ex.Token{access_token:  auth_token, refresh_token: my_refresh_token, token_type: "bearer", auth_header: "Bearer", storage: nil})
      new_token = Struct.Services.UpdateOauthToken.call(old_access_token: auth_token, new_token: new_token) 
      token = %OAuth2Ex.Token{
        access_token:  new_token.oauth_token,
        expires_in:    nil,
        expires_at:    nil,
        refresh_token: new_token.oauth_refresh_token,
        token_type:    "bearer",
        auth_header:   "Bearer",
        storage:       nil
      }
    else
      token = %OAuth2Ex.Token{
        access_token:  auth_token,
        expires_in:    nil,
        expires_at:    nil,
        refresh_token: my_refresh_token,
        token_type:    "bearer",
        auth_header:   "Bearer",
        storage:       nil
      }
    end
  end

  def me(token) do
    response = OAuth2Ex.HTTP.get(
                  token, "https://api.meetup.com/2/member/self")
    response.body |> JSEX.decode!
  end

  def groups(token, member_id) do
    response = OAuth2Ex.HTTP.get(
                  token, "https://api.meetup.com/2/groups?member_id=#{member_id}")
    response.body |> JSEX.decode!
  end

  def group(token, group_id) do
    response = OAuth2Ex.HTTP.get(
                  token, "https://api.meetup.com/2/groups?group_id=#{group_id}")
    group = JSEX.decode!(response.body)
    Enum.at(group["results"], 0)
  end


end