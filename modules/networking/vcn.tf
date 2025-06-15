 resource "oci_core_virtual_network" "vcn" {
  compartment_id = var.compartment_id # ID du compartiment OCI où le VCN sera créé
  cidr_block     = var.vcn_cidr       # Bloc CIDR pour le VCN (ex. "10.0.0.0/16")
  display_name   = "my_vcn"           # Nom visible du VCN dans la console OCI
  dns_label      = var.vcn_dns_label  # Préfixe DNS du VCN, utilisé dans le nom de domaine interne
}
