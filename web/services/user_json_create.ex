defmodule Struct.Services.UserJsonCreate do
  import Ecto.Query, only: [from: 2]

  def call(options) do
    user = options[:user]
    include_key = options[:include_key] || false
    user_struct = User.to_struct(user)
    current_stream = User.current_stream(user)
    if current_stream, do: user_struct = Map.put(user_struct, :current_stream_id, current_stream.id)

    query = from(a in Authorization, where: a.user_id == ^(user.id), select: a)
    authorizations = Repo.all(query)

    authorizations_s = for a <- authorizations, do: Authorization.to_struct(a)
    authorization_ids = for a <- authorizations, do: a.id

    user_struct = Map.put(user_struct, :authorization_ids, authorization_ids)

    user_json = %{user: user_struct}
    user_json = Struct.Services.StreamJsonInject.call(stream: current_stream, inject: user_json, include_key: include_key)

    user_json = Map.put(user_json, :authorizations, authorizations_s)


    user_json
  end

end