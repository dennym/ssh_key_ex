defmodule SshKeyEx.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ssh_key_ex,
      version: @version,
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      name: "SSHKeyEx",
      docs: [main: "readme", extras: ["README.md"]]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      files: ["lib", "native", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Denny Mueller"],
      licenses: ["Apache-2.0"],
      links: %{
        GitHub: "https://github.com/dennym/ssh_key_ex"
      }
    ]
  end

  defp description do
    "SSHKeyEx is a library for working with SSH keys in Elixir through rust `ssh_key` as nif implementations"
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.36.1", runtime: false},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end
end
