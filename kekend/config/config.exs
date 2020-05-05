use Mix.Config

config :serial_killer, port: 4000

import_config "#{Mix.env()}.exs"
