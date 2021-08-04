defmodule Binlist.Mixfile do
  use Mix.Project

  def project do
    [
      app: :binlist,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      preferred_cli_env: [
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :poison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:poison, "~> 5.0"},
      {:exvcr, "~> 0.11", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  def docs do
    [
      main: Binlist,
      canonical: "http://hexdocs.pm/binlist",
      source_url: "https://github.com/javierjulio/binlist-elixir",
      readme: "README.md"
    ]
  end

  defp package do
    [
      description: "An Elixir client library for the Binlist.net service.",
      files: ["lib", "mix.exs", "README.md", "CHANGELOG.md", "LICENSE*"],
      maintainers: ["Javier Julio"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/javierjulio/binlist-elixir"}
    ]
  end
end
