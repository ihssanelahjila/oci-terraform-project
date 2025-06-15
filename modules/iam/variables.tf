/*
variable "tenancy_ocid" {
  description = "OCID du tenancy OCI"
  type        = string
  sensitive   = true
}

variable "compartment_id" {
  type        = string
  description = "OCID du compartment pour les ressources "
  default     = "ocid1.compartment.oc1..aaaaaaaalgeo6o2kmsiyipyd533r7vw3cr4zp7jppboltn3mt76llh7kidyq"
}

variable "user_email" {
  description = "Email de l'utilisateur Dev"
  type        = string
  validation {
    condition     = can(regex("^[^@]+@[^@]+\\.[^@]+$", var.user_email))
    error_message = "Doit être une adresse email valide."
  }
  default          = "stagiaire9@nplusone.ma"
}

variable "env" {
  description = "Environnement (dev/prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "Doit être dev ou prod."
  }
}

*/

/*variable "policy_compartment_name" {
  description = "Nom du compartiment dans lequel la politique IAM s'applique"
  type        = string
  default     = "dev-compartment"
}
