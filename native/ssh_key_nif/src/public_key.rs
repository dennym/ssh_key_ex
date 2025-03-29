use rustler::NifStruct;
use ssh_key::PublicKey;

#[derive(NifStruct)]
#[module = "SSHKeyEx.PublicKey"]
struct PublicKeyNif {
    algorithm: String,
    comment: String,
}

#[rustler::nif]
fn pub_from_openssh(encoded_key: &str) -> Result<PublicKeyNif, String> {
    let public_key = PublicKey::from_openssh(encoded_key);

    match public_key {
        Ok(public_key) => {
            let public_key_nif = PublicKeyNif {
                algorithm: public_key.algorithm().as_str().to_string(),
                comment: public_key.comment().to_string(),
            };
            Ok(public_key_nif)
        }
        Err(error) => Err(error.to_string()),
    }
}
