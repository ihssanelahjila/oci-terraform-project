
# Si Tu y stockes ton secret chiffré (mot de passe, token…). Il est automatiquement chiffré avec la clé KMS, puis mis dans le Vault.
resource "oci_vault_secret" "secret" {
  compartment_id = var.compartment_id
  secret_name    = var.secret_name
  vault_id       = oci_kms_vault.vault.id
  key_id         = oci_kms_key.key.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.secret_content)
  }


 
}


