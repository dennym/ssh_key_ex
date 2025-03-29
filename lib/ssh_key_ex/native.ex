defmodule SSHKeyEx.Native do
  @moduledoc """
  Documentation for `SSHKeyEx.Native`.
  """

  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :ssh_key_ex,
    crate: "ssh_key_nif",
    base_url: "https://github.com/dennym/ssh_key_ex/releases/download/v#{version}",
    force_build: System.get_env("RUSTLER_FORCE_BUILD") in ["1", "true"],
    targets:
      Enum.uniq(["aarch64-unknown-linux-musl" | RustlerPrecompiled.Config.default_targets()]),
    version: version

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
