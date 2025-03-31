# SshKeyEx [![CI](https://github.com/dennym/ssh_key_ex/actions/workflows/elixir.yml/badge.svg)](https://github.com/dennym/ssh_key_ex/actions/workflows/elixir.yml) [![Hex Version](https://img.shields.io/hexpm/v/ssh_key_ex.svg)](https://hex.pm/packages/ssh_key_ex) [![Hex Docs](https://img.shields.io/badge/docs-hexpm-blue.svg)](https://hexdocs.pm/ssh_key_ex/)

SSHKeyEx is a library for working with SSH keys in Elixir through rust `ssh_key` as nif implementations. Currently it only implements parts of the `PublicKey.from_openssh` functionality to parse out the comment and the used algorithm of the given binary.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ssh_key_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ssh_key_ex, "~> 0.6.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ssh_key_ex>.

