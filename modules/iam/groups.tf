
resource "oci_identity_group" "dev_group" {
  name           = "dev_group_${var.env}"
  description    = "Groupe principal pour les développeurs"
  compartment_id = var.tenancy_ocid
}

