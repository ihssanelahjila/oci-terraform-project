
output "dev_group_id" {
  description = "OCID du groupe dev"
  value       = oci_identity_group.dev_group.id
}

output "dev_group_name" {
  description = "Nom du groupe dev"
  value       = oci_identity_group.dev_group.name
}

output "dev_user_id" {
  description = "OCID de l'utilisateur dev"
  value       = oci_identity_user.dev_user.id
  sensitive   = true
}

output "dev_user_email" {
  description = "Email de l'utilisateur dev"
  value       = oci_identity_user.dev_user.email
  sensitive   = true
}

output "policy_id" {
  description = "OCID de la politique IAM"
  value       = oci_identity_policy.dev_policy.id
}
