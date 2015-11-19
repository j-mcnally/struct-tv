defmodule Struct.Services.ChannelFind do
  import Ecto.Query, only: [from: 2]

  def call(options) do
    # Lookup channel data with github client
    {ext_id, _}       = Integer.parse("#{options[:ext_id]}")
    ext_provider = options[:ext_provider]
    from(c in Channel, where: c.ext_id == ^(ext_id) and c.ext_provider == ^(ext_provider), select: c, limit: 1) |>
    Repo.all |>
    Enum.at(0)
  end

end