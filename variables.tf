# Configuration OCI de base
variable "compartment_id" {
  type        = string
  description = "OCID du compartment pour les ressources "
}


variable "availability_domain" {
  description = "Domaine de disponibilité (ex: 1, 2 ou 3)"
  type        = string
}

variable "tenancy_ocid" {
  description = "OCID of your tenancy"
  type        = string
}

variable "user_ocid" {
  description = "OCID of your user"
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint of your API key"
  type        = string
}

variable "private_key_path" {
  description = "Path to your private key file"
  type        = string
}

variable "region" {
  description = "OCI region"
  type        = string
}



# Configuration Compute
variable "ssh_public_key" {
  description = "Clé publique SSH pour les instances"
  type        = string
}







