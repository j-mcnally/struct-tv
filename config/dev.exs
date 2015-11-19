use Mix.Config

config :phoenix, Struct.Router,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true,
  oauth_callback: "http://struct.lvh.me:4000"

config :exq,
  host: '127.0.0.1',
  port: 6379,
  namespace: 'structtv',
  queues: [{"encoding", 1}, {"mail", 5}]

config :phoenix, :code_reloader, true

config :logger, :console,
  level: :debug


