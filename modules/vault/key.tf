
#clé utilisée pour chiffrer et protéger ton secret.
resource "oci_kms_key" "key" {
  compartment_id = var.compartment_id
  display_name   = var.key_name
  management_endpoint = oci_kms_vault.vault.management_endpoint
  key_shape {
    algorithm = "AES"
    length    = 32
  }

  
}
