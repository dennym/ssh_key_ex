defmodule SSHKeyEx.PrivateKey do
  @moduledoc """
  Documentation for `SSHKeyEx.PrivateKey`.
  """

  alias SSHKeyEx.Native

  defstruct algorithm: "", comment: "", encrypted: false

  @type t :: %__MODULE__{algorithm: String.t(), comment: String.t()}

  @doc """
  Parses an OpenSSH format private key and returns a PrivateKey struct.

  The key must be in the standard OpenSSH format, starting with "-----BEGIN OPENSSH PRIVATE KEY-----"
  and ending with "-----END OPENSSH PRIVATE KEY-----".

  ## Parameters
    * `key` - Binary string containing the OpenSSH formatted private key

  ## Returns
    * `{:ok, private_key}` - Successfully parsed key as PrivateKey struct
    * `{:error, reason}` - If the key is invalid or cannot be parsed

  ## Examples

      iex> key = \"\"\"
      ...> -----BEGIN OPENSSH PRIVATE KEY-----
      ...> b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
      ...> QyNTUxOQAAACBaNssLYZcsr4VYHx6QhuNWdXV5AkeflMyZkagoRL4k3gAAAJgzrB/7M6wf
      ...> +wAAAAtzc2gtZWQyNTUxOQAAACBaNssLYZcsr4VYHx6QhuNWdXV5AkeflMyZkagoRL4k3g
      ...> AAAECJgH6e6W8QVn3XzXJsrgu3mz0nlIJHHJzzBOKscDulYFo2ywthlyyvhVgfHpCG41Z1
      ...> dXkCR5+UzJmRqChEviTeAAAADmN1cEBzYXVjZXIuY29tAQIDBAUGBw==
      ...> -----END OPENSSH PRIVATE KEY-----
      ...> \"\"\"
      iex> SSHKeyEx.PrivateKey.from_openssh(key)
      {:ok, %SSHKeyEx.PrivateKey{algorithm: "ssh-ed25519", comment: "cup@saucer.com"}}

  """
  @spec from_openssh(binary()) :: {:ok, __MODULE__.t()} | {:error, term()}
  def from_openssh(key), do: Native.priv_from_openssh(key)
end
