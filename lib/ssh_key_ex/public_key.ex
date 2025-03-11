defmodule PublicKey do
end

defmodule SSHKeyEx.PublicKey do
  use Rustler, otp_app: :ssh_key_ex, crate: "ssh_key_nif"

  defstruct key_data: "", comment: ""

  defp error() do
    :erlang.nif_error(:nif_not_loaded)
  end

  # When your NIF is loaded, it will override this function.
  @spec add(integer(), integer()) :: integer()
  def add(a, b), do: error()

  @spec from_openssh(binary()) :: term()
  def from_openssh(key), do: error()
end
