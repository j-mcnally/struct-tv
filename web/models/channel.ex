defmodule Channel do
  use Ecto.Model

  # weather is the DB table
  schema "channels" do
    field :github_id,     :integer
    field :ext_id,        :integer
    field :ext_provider,  :string
    field :title,         :string
    field :description,   :string
    field :project_url,   :string
    field :image,         :string
    field :popularity,    :float, default: 0.0
    field :created_at,    :datetime

    has_many :streams, LiveStream

  end

  def to_struct(obj) do
    %{
             id: obj.id,
      github_id: obj.github_id,
         ext_id: obj.ext_id,
   ext_provider: obj.ext_provider,
          title: obj.title,
    description: obj.description,
    project_url: obj.project_url,
          image: obj.image
    }
  end

end