defmodule Struct.Services.ChannelCreate do
  alias OAuth2Ex.Provider.Github, as: Github
  alias OAuth2Ex.Provider.Meetup, as: Meetup

  def call(options) do
    # Lookup channel data with github client
    oauth_token  = options[:oauth_token]
    ext_id       = options[:ext_id]
    ext_provider = options[:ext_provider]
    channel = Struct.Services.ChannelFind.call(ext_id: ext_id, ext_provider: ext_provider)
    if !channel do
      if ext_provider == "Github" do
        repo = Github.repo(oauth_token, "#{ext_id}")
        channel = %Channel{ext_id: repo["id"], ext_provider: "Github", title: repo["name"], project_url: repo["html_url"], description: repo["description"], image: repo["owner"]["avatar_url"]}
        channel = Repo.insert(channel)
      end
      if ext_provider == "Meetup" do
        group = Meetup.group(oauth_token, "#{ext_id}")
        img = group["group_photo"] || %{}
        channel = %Channel{ext_id: group["id"], ext_provider: "Meetup", title: group["name"], project_url: group["link"], description: group["description"], image: img["photo_link"]}
        channel = Repo.insert(channel)
      end
    end
    channel
  end

end