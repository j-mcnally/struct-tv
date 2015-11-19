defmodule Struct.Services.StreamRecordingsFind do
  import Ecto.Query, only: [from: 2, where: 3]

  def call(options) do
    stream = options[:stream]
    
    if stream do
      query = from(r in Recording, where: r.stream_id == ^(stream.id), select: r)
      result = Repo.all(query)
    end

  end
end