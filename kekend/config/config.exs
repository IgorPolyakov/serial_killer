use Mix.Config

config :imdb, Imdb.Endpoint, port: 4000
config :imdb, redirect_url: "http://localhost:4000/"

import_config "#{Mix.env()}.exs"
