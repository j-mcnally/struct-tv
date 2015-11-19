defmodule Struct.Services.StreamFeatured do
  import Ecto.Query, only: [from: 2]

  def call() do

      query = from(s in LiveStream, where: not(is_nil(s.started_at)) and is_nil(s.ended_at), order_by: [desc: s.featured_at], preload: [:channel, :user], select: s, limit: 1)
      Enum.at(Repo.all(query), 0)

  end
end