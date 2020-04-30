use Mix.Config

config :serial_killer, SerialKiller.Endpoint, port: 4000
config :serial_killer, redirect_url: "http://localhost:4000/"

import_config "#{Mix.env()}.exs"

config :serial_killer, db: [
  pool: DBConnection.ConnectionPool,
  pool_size: 20,
]
