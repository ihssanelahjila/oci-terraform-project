
variable "compartment_id" {
  description = "The OCID of the compartment"
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaalgeo6o2kmsiyipyd533r7vw3cr4zp7jppboltn3mt76llh7kidyq"
}

variable "key_name" {
  description = "The name of the encryption key"
  type        = string
  default     = "The encryption key"
}


variable "secret_name" {
  description = "The name of the secret"
  type        = string
  default     = "my-secret-123"
}

variable "secret_content" {
  description = "The content of the secret"
  type        = string
  sensitive   = true
  default     = "ihssane"
}

