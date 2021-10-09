defmodule Holodex.MixProject do
  use Mix.Project

  @app :holodex
  @git_url "todo"
  @home_url @git_url
  @version "0.1.0"

  @deps [
	{:poison, "~> 5.0"},
    {:httpoison, "~> 1.8"},
    {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
	{:dialyxir, "~> 1.0", only: [:dev], runtime: false},
	{:ex_doc, "~> 0.25.1", only: :dev},
	{:exconstructor, "~> 1.2.4"}
  ]

  @package [
    name: @app,
	files: ["lib", "mix.exs", "README*", "LICENSE"],
	maintainers: ["Daniils Petrovs"],
	licenses: ["GNU GPLv3"]
  ]

  @description "An Elixir client library for the Holodex API."

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.11",
	  build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      deps: @deps,
      description: @description,
      package: @package,
	  source_url: @home_url
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end
end
