defmodule Struct.Services.StreamPopular do
  import Ecto.Query, only: [from: 2, where: 3]

  def call() do    
    query = from(s in LiveStream, select: s, where: not(is_nil(s.started_at)), order_by: [desc: s.created_at])
    Repo.all(query)
  end
end