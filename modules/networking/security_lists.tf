resource "oci_core_security_list" "public_security_list" {
  compartment_id = var.compartment_id
  vcn_id         =  oci_core_virtual_network.vcn.id
  display_name   = "public_security_list"

  //  Règles dynamiques pour TCP (SSH, HTTP, HTTPS)
  dynamic "ingress_security_rules" {
    for_each = var.public_ingress_rules
    content {
      protocol = ingress_security_rules.value.protocol
      source   = ingress_security_rules.value.source

      tcp_options {
        min = ingress_security_rules.value.port
        max = ingress_security_rules.value.port
      }
    }
  }

  //  Règle statique ICMP (type 3, code 4)
  ingress_security_rules {
    description = var.security_list_ingress_security_rules_description
    protocol    = "1" // ICMP
    source      = "0.0.0.0/0"
    stateless   = true

    icmp_options {
      type = 3
      code = 4
    }
  }

  // Règles dynamiques de sortie
  dynamic "egress_security_rules" {
    for_each = var.public_egress_rules
    content {
      protocol    = egress_security_rules.value.protocol
      destination = egress_security_rules.value.destination
    }
  }
}
#FOR PRVVVVVVVVVVVVV***************************************************

resource "oci_core_security_list" "private_security_list" {
  compartment_id = var.compartment_id
  vcn_id         =  oci_core_virtual_network.vcn.id
  display_name   = "private_security_list"

  //  Règles dynamiques pour TCP
  dynamic "ingress_security_rules" {
    for_each = var.private_ingress_rules
    content {
      protocol = ingress_security_rules.value.protocol
      source   = ingress_security_rules.value.source

      tcp_options {
        min = ingress_security_rules.value.port
        max = ingress_security_rules.value.port
      }
    }
  }

  //  Règle statique ICMP (type 3, code 4)
  ingress_security_rules {
    description = var.security_list_ingress_security_rules_description
    protocol    = "1" // ICMP
    source      = "0.0.0.0/0"
    stateless   = true

    icmp_options {
      type = 3
      code = 4
    }
  }

  // Règles dynamiques de sortie
  dynamic "egress_security_rules" {
    for_each = var.private_egress_rules
    content {
      protocol    = egress_security_rules.value.protocol
      destination = egress_security_rules.value.destination
    }
  }
}