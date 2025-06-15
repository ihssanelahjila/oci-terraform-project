resource "oci_identity_policy" "dev_policy" {
  name           = "Dev-Policy"
  description    = "Politique d'accès pour l'équipe Dev"
  compartment_id = var.tenancy_ocid

  statements = [
    "Allow group dev_group to manage all-resources in compartment ${var.compartment_id}",
    "Allow group dev_group to read metrics in tenancy",
    "Allow group dev_group to read audit-events in tenancy"
  ]
}
