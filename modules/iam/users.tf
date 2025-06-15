resource "oci_identity_user" "dev_user" {
  name           = var.user_email
  description    = "Utilisateur Dev standard"
  email          = var.user_email
  compartment_id = var.tenancy_ocid
}

resource "oci_identity_user_group_membership" "dev_membership" {
  user_id  = oci_identity_user.dev_user.id
  group_id = oci_identity_group.dev_group.id
}

