use Mix.Config

config :phoenix, Struct.Router,
  http: [port: System.get_env("PORT") || 4001],
  debug_errors: true

config :phoenix, :exq,
  host: '127.0.0.1',
  port: 6379,
  namespace: 'structtv',
  queues: [{"encoding", 1}, {"mail", 5}]

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


