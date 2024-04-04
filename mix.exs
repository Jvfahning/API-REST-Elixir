defmodule FipeApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :fipe_api,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 2.2"},
      {:jason, "~> 1.4"}
    ]
  end

  defp start(_type, _args) do
    FipeCLI.run()
  end
end
