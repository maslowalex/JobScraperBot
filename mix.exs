defmodule Periodical.MixProject do
  use Mix.Project

  def project do
    [
      app: :periodical,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: false,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Periodical.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:postgrex, "~> 0.15.1"},
      {:ecto_sql, "~> 3.0"},
      {:httpoison, "~> 1.6"},
      {:floki, "~> 0.23.0"},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:ex_gram, "~> 0.8"},
      {:tesla, "~> 1.2"},
      {:jason, ">= 1.0.0"},
      {:ex_machina, "~> 2.3", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
  defp aliases do
    [
     test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
