defmodule SSHKeyEx.PublicKey do
  @moduledoc """
  Documentation for `SSHKeyEx.PublicKey`.
  """

  use Rustler, otp_app: :ssh_key_ex, crate: "ssh_key_nif"

  defstruct key_data: "", comment: ""

  defp error() do
    :erlang.nif_error(:nif_not_loaded)
  end

  @doc """
  Hello world.

  ## Examples

      iex> SSHKeyEx.PublicKey.from_openssh(certificate)
      :world

  """
  @spec from_openssh(binary()) :: term()
  def from_openssh(key), do: error()
end
