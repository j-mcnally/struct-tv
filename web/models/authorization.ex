defmodule Authorization do
  use Ecto.Model
  import Ecto.Query, only: [from: 2]

  schema "authorizations" do
    field    :oauth_id,        :string
    field    :oauth_provider,  :string
    field    :oauth_token,     :string
    field    :refresh_token,   :string
    field    :expires_at,      :datetime
    belongs_to :user,          User
  end

  
  def to_struct(obj) do
    %{
                  id: obj.id,
             user_id: obj.user_id,
            oauth_id: obj.oauth_id,
      oauth_provider: obj.oauth_provider,
    }
  end

end