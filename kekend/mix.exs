defmodule Imdb.MixProject do
  use Mix.Project

  def project do
    [
      app: :imdb,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Imdb.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2"},
      {:plug, "~> 1.7"},
      {:cowboy, "~> 2.5"},
      {:credo, "~> 0.10"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, "~> 0.15"}
    ]
  end
end
