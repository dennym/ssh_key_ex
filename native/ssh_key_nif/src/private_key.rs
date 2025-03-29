use rustler::NifStruct;
use ssh_key::PrivateKey;

#[derive(NifStruct)]
#[module = "SSHKeyEx.PrivateKey"]
struct PrivateKeyNif {
    algorithm: String,
    comment: String,
    encrypted: bool,
}

#[rustler::nif]
fn priv_from_openssh(encoded_key: &str) -> Result<PrivateKeyNif, String> {
    let private_key = PrivateKey::from_openssh(encoded_key);

    match private_key {
        Ok(private_key) => {
            let private_key_nif = PrivateKeyNif {
                algorithm: private_key.algorithm().as_str().to_string(),
                comment: private_key.comment().to_string(),
                encrypted: private_key.is_encrypted(),
            };
            Ok(private_key_nif)
        }
        Err(error) => Err(error.to_string()),
    }
}
