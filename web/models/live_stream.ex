defmodule LiveStream do
  use Ecto.Model
  use Timex

  schema "streams" do
    field :title,       :string
    field :description, :string
    field :streamkey,   :string
    field :started_at,  :datetime
    field :featured_at, :datetime
    field :ended_at,    :datetime
    field :created_at,  :datetime
    field :viewers_current, :integer
    field :viewers_total, :integer


    has_many :recordings, Recording
    
    belongs_to :user, User
    belongs_to :channel, Channel
  end

  def to_struct(obj, include_key) do
    atr = %{
                   id: obj.id,
                title: obj.title,
          description: obj.description,
           channel_id: obj.channel_id,
              user_id: obj.user_id,
                 full: false,
      viewers_current: ((obj.viewers_current || 0) + 1),
        viewers_total: ((obj.viewers_total || 0) + 1),
           started_at: Struct.Services.DateSerializer.call(date: obj.started_at),
             ended_at: Struct.Services.DateSerializer.call(date: obj.ended_at)
    }
    if include_key, do: atr = Map.put(atr, :streamkey, obj.streamkey)
    atr
  end
end