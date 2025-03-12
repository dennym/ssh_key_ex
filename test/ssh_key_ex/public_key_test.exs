defmodule SSHKeyEx.PublicKeyTest do
  use ExUnit.Case
  # doctest SSHKeyEx.PublicKey

  alias SSHKeyEx.PublicKey

  test "parses ed25519 public key into PublicKey struct" do
    certificate = File.read!("test/support/id_ed25519.pub")
    {:ok, key_information} = PublicKey.from_openssh(certificate)

    assert %{comment: "cup@saucer.com"} = key_information
    assert %{algorithm: "ssh-ed25519"} = key_information
  end

  test "parses rsa public key into PublicKey struct" do
    certificate = File.read!("test/support/id_rsa.pub")
    {:ok, key_information} = PublicKey.from_openssh(certificate)

    assert %{comment: "cup@saucer.com"} = key_information
    assert %{algorithm: "ssh-rsa"} = key_information
  end
end
