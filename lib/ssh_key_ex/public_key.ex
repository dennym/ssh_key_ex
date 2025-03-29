defmodule SSHKeyEx.PublicKey do
  @moduledoc """
  Documentation for `SSHKeyEx.PublicKey`.
  """

  alias SSHKeyEx.Native

  defstruct algorithm: "", comment: ""

  @type t :: %__MODULE__{algorithm: String.t(), comment: String.t()}

  @doc """
  Parses an OpenSSH format public key string into a PublicKey struct.

  The function expects a string in the standard OpenSSH public key format:
  `<algorithm> <base64-encoded-key> <comment>\\n`

  ## Parameters
    * `key` - A string containing the OpenSSH format public key

  ## Returns
    * `{:ok, %PublicKey{}}` - Successfully parsed public key with algorithm and comment
    * `{:error, term()}` - If the key format is invalid or parsing fails

  ## Examples

      iex> SSHKeyEx.PublicKey.from_openssh("ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFo2ywthlyyvhVgfHpCG41Z1dXkCR5+UzJmRqChEviTe cup@saucer.com\\n")
      {:ok, %SSHKeyEx.PublicKey{algorithm: "ssh-ed25519", comment: "cup@saucer.com"}}

  """
  @spec from_openssh(binary()) :: {:ok, __MODULE__.t()} | {:error, term()}
  def from_openssh(key), do: Native.pub_from_openssh(key)
end
