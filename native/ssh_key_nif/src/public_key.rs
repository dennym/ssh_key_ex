use rustler::{NifStruct, NifUnitEnum};
use ssh_key::PublicKey;

#[derive(NifStruct)]
#[module = "SSHKeyEx.PublicKey"]
struct PublicKeyNif {
    algorithm: String,
    comment: String,
}

#[derive(NifUnitEnum)]
enum PublicKeyErrorNif {
    AlgorithmUnknown,
    AlgorithmUnsupported,
    /// Cryptographic errors.
    Crypto,
    /// Cannot perform operation on decrypted private key.
    Decrypted,
    /// ECDSA key encoding errors.
    Ecdsa,
    /// Encoding errors.
    Encoding,
    /// Cannot perform operation on encrypted private key.
    Encrypted,
    /// Other format encoding errors.
    FormatEncoding,
    /// Namespace invalid.
    Namespace,
    /// Public key is incorrect.
    PublicKey,
}

#[rustler::nif]
fn from_openssh(encoded_key: &str) -> Result<PublicKeyNif, PublicKeyErrorNif> {
    let public_key = PublicKey::from_openssh(encoded_key);

    match public_key {
        Ok(public_key) => {
            let public_key_nif = PublicKeyNif {
                algorithm: public_key.algorithm().as_str().to_string(),
                comment: public_key.comment().to_string(),
            };
            Ok(public_key_nif)
        }
        Err(_) => Err(PublicKeyErrorNif::PublicKey),
    }
}

rustler::init!("Elixir.SSHKeyEx.PublicKey");
