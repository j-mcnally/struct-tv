defmodule Struct.Services.UpdateOauthToken do
  use Timex
  import Ecto.Query, only: [from: 2]
  
  def call(options) do
    old_access_token = options[:old_access_token]
    new_token = options[:new_token]
    {expires_in, _} = Integer.parse("#{Float.floor(new_token.expires_in / 100, 0)}")
    expiry = Date.convert(Date.universal(), :secs) + expires_in - 1000 
    epoc = :calendar.datetime_to_gregorian_seconds({{1970,1,1},{0,0,0}})
    expiry = Ecto.DateTime.from_erl(:calendar.gregorian_seconds_to_datetime(epoc + expiry))


    query = from(a in Authorization, where: a.oauth_token == ^(old_access_token), select: a, limit: 1)
    a = Enum.at(Repo.all(query), 0)
    a = %{a | oauth_token: new_token.access_token, refresh_token: new_token.refresh_token, expires_at: expiry}
    Repo.update(a)
    a
  end
end

