defmodule SSHKeyEx.Native do
  @moduledoc """
  Documentation for `SSHKeyEx.Native`.
  """

  use Rustler, otp_app: :ssh_key_ex, crate: "ssh_key_nif"

  defstruct algorithm: "", comment: "", encrypted: false

  @type t :: %__MODULE__{algorithm: String.t(), comment: String.t()}

  defp error() do
    :erlang.nif_error(:nif_not_loaded)
  end

  # PublicKey
  @spec pub_from_openssh(binary()) :: {:ok, __MODULE__.t()} | {:error, term()}
  def pub_from_openssh(_key), do: error()

  # PrivateKey
  @spec priv_from_openssh(binary()) :: {:ok, __MODULE__.t()} | {:error, term()}
  def priv_from_openssh(_key), do: error()
end
