# defmodule RiakClient do
#   use Riak

#   def conf do
#     host = System.get_env("RIAK_HOST") || "127.0.0.1"
#     port = System.get_env("RIAK_PORT") || "8087"
#     host = to_char_list(host)
#     port = elem(Integer.parse(port), 0)
#     Riak.configure(host: host, port: port)
#   end

# end