
output "vault_id" {
  description = "The OCID of the vault"
  value       = oci_kms_vault.vault.id
}

output "key_id" {
  description = "The OCID of the encryption key"
  value       = oci_kms_key.key.id
}

output "key_name" {
  description = "The display name of the encryption key"
  value       = oci_kms_key.key.display_name
}

output "secret_id" {
  description = "The OCID of the secret"
  value       = oci_vault_secret.secret.id
}

output "secret_name" {
  description = "The display name of the secret"
  value       = oci_vault_secret.secret.secret_name
}

output "secret_content" {
  description = "The base64 encoded secret content"
  value       = var.secret_content
  sensitive   = true
}
output "kms_management_endpoint" {
  description = "The KMS management endpoint"
  value       = oci_kms_vault.vault.management_endpoint
}

