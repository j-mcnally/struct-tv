defmodule Struct.Mixfile do
  use Mix.Project

  def project do
    [ app: :struct,
      version: "0.0.1",
      elixir: "~> 1.0.0",
      elixirc_paths: ["lib", "web", "web/services"],
      compilers: [:phoenix] ++ Mix.compilers,
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Struct, [] },
      applications: [:phoenix, :cowboy, :logger, :postgrex, :ecto, :oauth2ex]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:cowboy, "1.0.0"},
      {:decimal, "0.2.5"},
      {:postgrex, "0.6.0"},
      {:phoenix, "0.5.0"},
      {:ecto, "0.2.5"},
      {:uuid, "0.1.5"},
      {:timex, "0.12.8"},
      {:exq, github: "structtv/exq", branch: "concurrency"},
      {:jsex, "2.0.0"},
      {:jsx, "2.1.1"},
      #{:exq, path: "../exq"},
      #{:oauth2ex, path: "../oauth2ex"}
      {:oauth2ex, github: "j-mcnally/oauth2ex"}
    ]
  end
end
