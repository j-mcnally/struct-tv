defmodule Recording do
  use Ecto.Model
  use Timex

  schema "recordings" do
    field :path,  :string
    field :created_at,  :datetime
    
    belongs_to :stream, LiveStream
  end

  def to_struct(obj) do
    atr = %{
              id: obj.id,
            path: Path.basename(obj.path),
       stream_id: obj.stream_id,
      created_at: Struct.Services.DateSerializer.call(date: obj.created_at)
    }
  end
end