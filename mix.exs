defmodule HttpCounter.MixProject do
  use Mix.Project

  def project do
    [
      app: :http_counter,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HttpCounter.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"},
      {:libcluster, "~> 3.0"}
    ]
  end
end
