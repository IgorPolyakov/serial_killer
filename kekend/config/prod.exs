use Mix.Config

config :imdb, Imdb.Endpoint,
  port: String.to_integer(System.get_env("PORT") || "4444")

config :imdb, redirect_url: System.get_env("REDIRECT_URL")
