use rustler::{Atom, Env, NifResult, NifStruct, NifUnitEnum, ResourceArc, Term};
use ssh_key::PublicKey;

#[derive(NifStruct)]
#[module = "Elixir.SSHKeyEx.PublicKey"]
struct PublicKeyNif {
    algorithm: String,
    comment: String,
}

#[derive(NifUnitEnum)]
enum PublicKeyErrorNif {
    SomeError,
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
        Err(_) => Err(PublicKeyErrorNif::SomeError),
    }
}

rustler::init!("Elixir.SSHKeyEx.PublicKey");
