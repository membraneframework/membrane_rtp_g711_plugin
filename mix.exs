defmodule Membrane.RTP.G711.Mixfile do
  use Mix.Project

  @version "0.3.1"
  @github_url "https://github.com/jellyfish-dev/membrane_rtp_g711_plugin"

  def project do
    [
      app: :membrane_rtp_g711_plugin,
      version: @version,
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # hex
      description: "Membrane Multimedia Framework (RTP G711)",
      package: package(),

      # docs
      name: "Membrane RTP G711",
      source_url: @github_url,
      homepage_url: "https://membrane.stream",
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [],
      mod: {Membrane.RTP.G711.Plugin.App, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  defp deps do
    [
      {:membrane_core, "~> 1.0"},
      {:membrane_rtp_format, "~> 0.11.0"},
      {:membrane_g711_format, "~> 0.1.0"},
      {:ex_doc, ">=0.0.0", only: :dev, runtime: false},
      {:credo, ">=0.0.0", only: :dev, runtime: false},
      {:dialyxir, ">=0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Membrane Team"],
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => @github_url,
        "Membrane Framework Homepage" => "https://membrane.stream"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["LICENSE", "README.md"],
      formatters: ["html"],
      source_ref: "v#{@version}",
      nest_modules_by_prefix: [Membrane.RTP.G711]
    ]
  end
end
