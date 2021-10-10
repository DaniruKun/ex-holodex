defmodule Holodex.MixProject do
  use Mix.Project

  @app :holodex
  @git_url "https://github.com/DaniruKun/ex-holodex"
  @home_url @git_url
  @version "0.1.1"

  @deps [
    {:poison, "~> 5.0"},
    {:httpoison, "~> 1.8"},
    {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
    {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
    {:ex_doc, "~> 0.25.1", only: :dev},
	{:exvcr, "~> 0.12.0", only: [:dev, :test]}
  ]

  @package [
    name: @app,
    files: ["lib", "mix.exs", "README*", "LICENSE"],
    maintainers: ["danirukun"],
    licenses: ["GNU GPLv3"],
    links: %{
      "Github" => @home_url,
      "Holodex" => "https://holodex.net",
      "Website" => "https://danpetrov.xyz"
    }
  ]

  @description "An Elixir client library for the Holodex API."

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.11",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: @deps,
      description: @description,
      package: @package,
      source_url: @home_url,
      docs: [
        main: Holodex,
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end
end
