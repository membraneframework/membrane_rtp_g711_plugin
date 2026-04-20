defmodule Membrane.RTP.G711.Mixfile do
  use Mix.Project

  @version "0.3.3"
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
      docs: docs(),
      aliases: [docs: ["docs", &prepend_llms_links/1]]
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
      {:ex_doc, "~> 0.40", only: :dev, runtime: false},
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
      source_ref: "v#{@version}",
      nest_modules_by_prefix: [Membrane.RTP.G711]
    ]
  end

  defp prepend_llms_links(_) do
    output_dir = docs()[:output] || "doc"
    path = Path.join(output_dir, "llms.txt")

    if File.exists?(path) do
      existing = File.read!(path)

      footer = """


      ## See Also

      - [Membrane Framework AI Skill](https://hexdocs.pm/membrane_core/skill.md)
      - [Membrane Core](https://hexdocs.pm/membrane_core/llms.txt)
      """

      File.write!(path, String.trim_trailing(existing) <> footer)
    else
      IO.warn("#{path} not found — llms.txt was not generated, check your ex_doc configuration")
    end
  end
end
