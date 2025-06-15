resource "oci_core_subnet" "public_subnet_1" {
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_virtual_network.vcn.id
  cidr_block          = var.public_subnet_1_cidr
  availability_domain = var.availability_domain
  display_name        = "public_subnet_1"
  dns_label           = var.public_subnet_1_dns_label
  route_table_id      = oci_core_route_table.public_rt.id
}

resource "oci_core_subnet" "public_subnet_2" {
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_virtual_network.vcn.id
  cidr_block          = var.public_subnet_2_cidr
  availability_domain = var.availability_domain_2
  display_name        = "public_subnet_2"
  dns_label           = var.public_subnet_2_dns_label
  route_table_id      = oci_core_route_table.public_rt.id
}

resource "oci_core_subnet" "private_subnet_1" {
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_virtual_network.vcn.id
  cidr_block          = var.private_subnet_1_cidr
  availability_domain = var.availability_domain
  display_name        = "private_subnet_1"
  dns_label           = var.private_subnet_1_dns_label
  
  route_table_id      = oci_core_route_table.private_rt.id
  prohibit_public_ip_on_vnic = true  #  Empêche les IPs publiques
  security_list_ids = [oci_core_security_list.private_security_list.id]
}

resource "oci_core_subnet" "private_subnet_2" {
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_virtual_network.vcn.id
  cidr_block          = var.private_subnet_2_cidr
  availability_domain = var.availability_domain
  display_name        = "private_subnet_2"
  dns_label           = var.private_subnet_2_dns_label
  prohibit_public_ip_on_vnic = true  #  Empêche les IPs publiques
  security_list_ids = [oci_core_security_list.private_security_list.id]
  
  route_table_id      = oci_core_route_table.private_rt.id
}
