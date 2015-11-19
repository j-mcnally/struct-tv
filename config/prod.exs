use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Struct.Router,
  url: [host: "struct.tv"],
  http: [port: System.get_env("PORT") || 4000],
  secret_key_base: "fBo57aOk5sJI8SM+3TvhXQTZ3pAh4EtdrQeymDA6hqkL3SGYoyBmQmPRspIWmsNfJtmvnlwmUt3ubg3YaTxYbw==",
  oauth_callback: "http://struct.tv"

config :exq,
  host: '127.0.0.1',
  port: 6379,
  namespace: 'structtv',
  queues: [{"encoding", 1}, {"mail", 5}]

config :logger, :console,
  level: :info,
  metadata: [:request_id]

