defmodule SSHKeyEx.PublicKey do
  @moduledoc """
  Documentation for `SSHKeyEx.PublicKey`.
  """

  use Rustler, otp_app: :ssh_key_ex, crate: "ssh_key_nif"

  defstruct algorithm: "", comment: ""

  @type t :: %__MODULE__{algorithm: String.t(), comment: String.t()}

  defp error() do
    :erlang.nif_error(:nif_not_loaded)
  end

  @doc """
  ## Examples

      iex> SSHKeyEx.PublicKey.from_openssh("ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFo2ywthlyyvhVgfHpCG41Z1dXkCR5+UzJmRqChEviTe cup@saucer.com\\n")
      {:ok, %SSHKeyEx.PublicKey{algorithm: "ssh-ed25519", comment: "cup@saucer.com"}}

  """
  @spec from_openssh(binary()) :: {:ok, __MODULE__.t()} | {:error, term()}
  def from_openssh(_key), do: error()
end
