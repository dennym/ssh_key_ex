defmodule SSHKeyEx.PublicKeyTest do
  use ExUnit.Case
  doctest SSHKeyEx.PublicKey

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

  test "parses dsa public key into PublicKey struct" do
    certificate = File.read!("test/support/id_dsa.pub")
    {:ok, key_information} = PublicKey.from_openssh(certificate)

    assert %{comment: "cup@saucer.com"} = key_information
    assert %{algorithm: "ssh-dss"} = key_information
  end

  test "parses ecdsa-sha2-nistp256 public key into PublicKey struct" do
    certificate = File.read!("test/support/id_ecdsa256.pub")
    {:ok, key_information} = PublicKey.from_openssh(certificate)

    assert %{comment: "cup@saucer.com"} = key_information
    assert %{algorithm: "ecdsa-sha2-nistp256"} = key_information
  end

  test "parses ecdsa-sha2-nistp384 public key into PublicKey struct" do
    certificate = File.read!("test/support/id_ecdsa384.pub")
    {:ok, key_information} = PublicKey.from_openssh(certificate)

    assert %{comment: "cup@saucer.com"} = key_information
    assert %{algorithm: "ecdsa-sha2-nistp384"} = key_information
  end

  test "parses ecdsa-sha2-nistp521 public key into PublicKey struct" do
    certificate = File.read!("test/support/id_ecdsa521.pub")
    {:ok, key_information} = PublicKey.from_openssh(certificate)

    assert %{comment: "cup@saucer.com"} = key_information
    assert %{algorithm: "ecdsa-sha2-nistp521"} = key_information
  end

  test "returns character encoding error when public key has changed characters" do
    certificate =
      "
ssh-dss AAAAB3NzaC1kc3MAAACBAIoIru2FDfOBTkGFyy7nNxONrSrhNSHiVXnXIxzS3WNjREP0NA4W2Gg6uyRk+zWAmouF2ARrZrh0KZtHm+EdYvjU9QciG4c88+w6r8dV2oQlOxY5WtuM7jJu7VUH+Dt0uMZovtdtWPAKfq7xtpiQ5Bta8LikODUpu6A+RvfABfdtAAAAFQDaqAlnpJuwrwCRPh6GNSaTXLd09QAAAIA8QweIKa0DFX/lhPM0zMM6GITcuFK1D6FHWFqYhqIkwbLrNIthOzqVsN/1kEVwRa2wFZQg+0oY2iOse/uSSH/9TYk1NbAa2CxMkbi1Hx8OOOaRCdW9gOqfxGZ4ATNF2Cu9hAV8EFu9GWoX4HdQB3X17xNXCy8yMlDctyX7JY8h9gAAAIAerdAbeh1eWG5w2RHqtPpQA8SI6PzZtlgQHhmC2waZLRtbV/IAB75hOoOWOb5EV8RLYRvEs8CZB/G6+PPQkmkosCxRKMdg+32u2javb0jB1xpEC9T5xopChAQcKSzMRUCKqmpJXAfY2kDbx+54RQiwJGnuyti7/p1+K3ZRA6by7A++ cup@saucer.com"

    assert {:error, "character encoding invalid"} =
             PublicKey.from_openssh(certificate)
  end

  test "returns trailing data error when public key has changed letters" do
    assert {:error, "unexpected trailing data at end of message (2 bytes)"} =
             File.read!("test/support/id_dsa.pub")
             |> String.replace("=", "+")
             |> SSHKeyEx.PublicKey.from_openssh()
  end

  test "returns base64 encoding error when public key has changed letters" do
    assert {:error, "Base64 encoding error: invalid Base64 encoding"} =
             "ssh-ed25519 AAAAC3NzaC1 cup@saucer.com"
             |> String.replace("=", "+")
             |> SSHKeyEx.PublicKey.from_openssh()
  end

  test "returns unknown algorithm error when public key has changed letters" do
    assert {:error, "unknown algorithm"} =
             "ssh-ssd AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBOA6hVJO70zLGFi9wxUlWDtqwDawFi7YAkTvBKE4nBm2+FsUyoW0U+/2dRhCJPU660CVTuu/VveyFnGY1A9/IGo= cup@saucer.com"
             |> SSHKeyEx.PublicKey.from_openssh()
  end
end
