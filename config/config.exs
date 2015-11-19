# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, Struct.Router,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  https: false,
  static_assets: true,
  secret_key_base: "fBo57aOk5sJI8SM+3TvhXQTZ3pAh4EtdrQeymDA6hqkL3SGYoyBmQmPRspIWmsNfJtmvnlwmUt3ubg3YaTxYbw==",
  catch_errors: true,
  debug_errors: false,
  error_controller: Struct.PageController

config :phoenix, Struct.Router,
  session: [store: :cookie,
            key: "_structtv_key"]

config :exq,
  host: '127.0.0.1',
  port: 6379,
  namespace: 'structtv',
  queues: [{"encoding", 1}, {"mail", 5}]


config :phoenix, :code_reloader, false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
