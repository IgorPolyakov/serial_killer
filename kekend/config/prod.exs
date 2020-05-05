use Mix.Config

config :serial_killer, port: String.to_integer(System.get_env("PORT") || "4444")

config :serial_killer, db: [
  pool_size: 20,
  database: "serial_killer",
  username: System.get_env("USERNAME") || "postgres",
  password: System.get_env("PASSWORD") || "postgres",
  hostname: System.get_env("HOSTNAME") || "localhost"
]
