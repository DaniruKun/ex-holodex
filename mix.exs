defmodule Holodex.MixProject do
  use Mix.Project

  @app :holodex
  @git_url "todo"
  @home_url @git_url
  @version "0.1.0"

  @deps [
    {:jason, "~> 1.2.2"},
    {:httpoison, "~> 1.8"},
    {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
	{:dialyxir, "~> 1.0", only: [:dev], runtime: false}
  ]

  @package [
    name: @app
  ]

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: @deps,
      description: "An Elixir client library for the Holodex API.",
      package: @package
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end
end
