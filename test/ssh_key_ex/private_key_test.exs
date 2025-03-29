defmodule SSHKeyEx.PrivateKeyTest do
  use ExUnit.Case
  doctest SSHKeyEx.PrivateKey

  alias SSHKeyEx.PrivateKey

  test "parses ed25519 private key into PrivateKey struct" do
    certificate = File.read!("test/support/id_ed25519")
    {:ok, key_information} = PrivateKey.from_openssh(certificate)

    assert %{comment: "cup@saucer.com"} = key_information
    assert %{algorithm: "ssh-ed25519"} = key_information
  end

  test "parses rsa private key into PrivateKey struct" do
    certificate = File.read!("test/support/id_rsa")
    {:ok, key_information} = PrivateKey.from_openssh(certificate)

    assert %{comment: "cup@saucer.com"} = key_information
    assert %{algorithm: "ssh-rsa"} = key_information
  end

  test "parses ecdsa-sha2-nistp256 private key into PrivateKey struct" do
    certificate = File.read!("test/support/id_ecdsa256")
    {:ok, key_information} = PrivateKey.from_openssh(certificate)

    assert %{comment: "cup@saucer.com"} = key_information
    assert %{algorithm: "ecdsa-sha2-nistp256"} = key_information
  end

  test "parses ecdsa-sha2-nistp384 private key into PrivateKey struct" do
    certificate = File.read!("test/support/id_ecdsa384")
    {:ok, key_information} = PrivateKey.from_openssh(certificate)

    assert %{comment: "cup@saucer.com"} = key_information
    assert %{algorithm: "ecdsa-sha2-nistp384"} = key_information
  end

  test "parses ecdsa-sha2-nistp521 private key into PrivateKey struct" do
    certificate = File.read!("test/support/id_ecdsa521")
    {:ok, key_information} = PrivateKey.from_openssh(certificate)

    assert %{comment: "cup@saucer.com"} = key_information
    assert %{algorithm: "ecdsa-sha2-nistp521"} = key_information
  end

  test "returns character encoding error when private key has changed characters" do
    assert {:error, "PEM preamble contains invalid data (NUL byte)"} =
             "FOOBAR"
             |> PrivateKey.from_openssh()
  end
end
