defmodule Blueprint.Mixfile do
  use Mix.Project

  def project do
    [
      app: :blueprint,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      test_coverage: [tool: Coverex.Task],
      deps: deps(),
      package: package(),
      source_url: "https://github.com/elixirscript/blueprint",
      elixir_script: [
        input: "lib"
      ]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:credo, "~> 0.7.3", only: [:dev, :test]},
      {:coverex, "~> 1.4.10", only: :test},
      {:ex_doc, "~> 0.15.1", only: [:dev]},
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Bryan Joseph"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/elixirscript/blueprint"
      },
      build_tools: ["mix"]
    ]
  end
end
