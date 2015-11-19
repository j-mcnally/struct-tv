defmodule Struct.AuthenticationPlug do
  alias Plug.Conn
  alias Phoenix.Status
  alias Phoenix.Controller.Errors
  alias Poison, as: JSON
  import Phoenix.Controller.Connection
  import Plug.Conn
  import Ecto.Query, only: [from: 2]

  def init(opts), do: opts

  def call(conn, _opts) do 
    if _opts[:only] && !(conn.private.phoenix_action in _opts[:only]) do
      conn 
    else
      authenticate(conn)
    end
  end 

  def authenticate(conn) do
    token = parse_token(conn)
    
    if token != "" do
      query = from(u in User, where: u.auth_token == ^(token), select: u)
      user = Enum.at(Repo.all(query), 0)
    end

    if user do
      assign(conn, :current_user, user)
    else
      json(conn, 401, JSON.encode!(%{error: "Unauthorized"})) |> halt
    end
  end

  defp parse_token(conn) do
    case Conn.get_req_header(conn, "authorization") do
      ["Token " <> parts|_] ->
        parts = String.split(parts, ",")
        Enum.find_value(parts, fn n ->
          case String.split(n, "=", parts: 2) do
            ["token", value] -> value
            _ -> nil
          end
        end)
      _ ->
        nil
    end
  end

end