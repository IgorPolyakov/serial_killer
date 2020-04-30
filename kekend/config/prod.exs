use Mix.Config

config :serial_killer, SerialKiller.Endpoint,
  port: String.to_integer(System.get_env("PORT") || "4444")

config :serial_killer, redirect_url: System.get_env("REDIRECT_URL")
