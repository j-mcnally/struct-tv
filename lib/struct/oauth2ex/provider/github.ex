defmodule OAuth2Ex.Provider.Github do
  require Logger
  @moduledoc """
  Provider for Github OAuth 2.0 API.

  API: https://developer.github.com/v3/oauth/
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
        id:            System.get_env("GITHUB_CLIENT_ID"),
        secret:        System.get_env("GITHUB_CLIENT_SECRET"),
        authorize_url: "https://github.com/login/oauth/authorize",
        token_url:     "https://github.com/login/oauth/access_token",
        scope:         "repo,user,admin:repo_hook",
        callback_url:  "#{callback}/oauth/github/code"
      )
    end

    def get_token(code) do
      OAuth2Ex.get_token(config, code)
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

  def mk_token(auth_token) do
    token = %OAuth2Ex.Token{
      access_token:  auth_token,
      expires_in:    nil,
      refresh_token: nil,
      token_type:    "bearer",
      auth_header:   "Bearer",
      storage:       nil
    }
  end

  def me(token) do
    response = OAuth2Ex.HTTP.get(
                  token, "https://api.github.com/user")
    response.body |> JSEX.decode!
  end

  def repos(token) do
    repos(token, "user")
  end

  def repos(token, scope) do
    repos(token, scope, nil)
  end

  def repos(token, scope, page) do
    if page do
      page = "?page=" <> page
    else
      page = ""
    end
    response = OAuth2Ex.HTTP.get(
                  token, "https://api.github.com/" <> scope <> "/repos" <> page)
    response |> metify
  end

  def repo(token, id) do
    response = OAuth2Ex.HTTP.get(
                  token, "https://api.github.com/repositories/" <> id)
    response.body |> JSEX.decode!
  end

  def organization(token, id) do
    response = OAuth2Ex.HTTP.get(
                  token, "https://api.github.com/orgs/" <> id)
    response.body |> JSEX.decode!
  end

  def organizations(token) do
    organizations(token, nil)
  end

  def organizations(token, page) do
    if page do
      page = "?page=" <> page
    else
      page = ""
    end
    response = OAuth2Ex.HTTP.get(
                  token, "https://api.github.com/user/orgs" <> page)
    response |> metify
  end

  def metify(response) do
    objects = response.body |> JSEX.decode!
    %{objects: objects, pagination: extract_links(response.headers["Link"])}
  end

  defp extract_links(link_string) do
    if link_string do
      parts = for link <- String.split(link_string, ", "), do: Regex.named_captures(~r/\<.*\?page=(?<page>.*)\>; rel=\"(?<position>.*)\"/, link, capture: :all_but_first)
      for capture <- parts, into: %{}, do: {Map.get(capture, "position"), Map.get(capture, "page")}
    end
  end

end