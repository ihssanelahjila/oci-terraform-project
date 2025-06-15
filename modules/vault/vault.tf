
#conteneur sécurisé qui va stocker les clés de chiffrement et les secrets.
resource "oci_kms_vault" "vault" {
  compartment_id = var.compartment_id
  display_name   = "terraform_vault"
  vault_type     = "DEFAULT"
}


