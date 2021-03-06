defmodule Opticontest.MixProject do
  use Mix.Project

  def project do
    [
      app: :opticontest,
      version: "0.0.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
    ]
  end

  def application do
    [
      extra_applications: [:logger],
    ]
  end

  defp deps do
    []
  end
end
