defmodule User do
  use Ecto.Model
  import Ecto.Query, only: [from: 2]

  validate user,
     username: present()

  schema "users" do
    field    :username,            :string
    field    :realname,            :string
    field    :avatar_url,          :string
    field    :profile,             :string
    field    :email,               :string
    field    :company,             :string
    field    :auth_token,          :string
    has_many :authorizations,      Authorization
    has_many :streams,             LiveStream
  end

  def get_auth_token(user) do
    # Check if user has an auth_token, otherwise generate one
    if user do
      if user.auth_token != nil && user.auth_token != "" do
        user.auth_token
      else
        guid = UUID.uuid4(:hex)
        %{user | auth_token: guid} |>
        Repo.update
        guid
      end
    end
  end


  def current_stream(user) do
    query = from s in LiveStream,
        where: s.user_id == ^(user.id),
     order_by: [desc: s.created_at],
        limit: 1,
        preload: :channel,
        select: s

    results = Repo.all(query)
    stream = nil
    if length(results) == 1 do
      [stream] = results
    end
    stream
  end

  def to_struct(obj) do
    %{
                  id: obj.id,
          avatar_url: obj.avatar_url,
             profile: obj.profile,
               email: obj.email,
            username: obj.username,
            realname: obj.realname
    }
  end

end