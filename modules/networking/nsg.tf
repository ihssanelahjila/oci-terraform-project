# NSG Public (pour ressources accessibles depuis Internet)
resource "oci_core_network_security_group" "public_nsg" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "public_nsg"
}

# NSG Privé (pour les backends dans les subnets privés)
resource "oci_core_network_security_group" "private_nsg" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id 
  display_name   = "private_nsg"
}

# NSG dédié pour le Load Balancer
resource "oci_core_network_security_group" "lb_nsg" {
  compartment_id = var.compartment_id
  vcn_id         =  oci_core_virtual_network.vcn.id
  display_name   = "nsg-${var.lb_type}-lb"
  #defined_tags   = var.defined_tags
}

### Règles pour le Load Balancer ###

# Règle 1 : Autoriser HTTP/HTTPS depuis Internet (Entrant)
resource "oci_core_network_security_group_security_rule" "lb_ingress_http" {
  network_security_group_id = oci_core_network_security_group.lb_nsg.id
  direction                = "INGRESS"  # Correction: "INGRESS" au lieu de "INGRESS"
  protocol                 = "6"  # TCP
  source                   = "0.0.0.0/0"  # Tout Internet peut accéder au LB
  source_type              = "CIDR_BLOCK"
  
  tcp_options {
    destination_port_range {
      min = 80   # HTTP
      max = 443  # HTTPS
    }
  }
}

# Règle 2 : Autoriser le LB à communiquer avec les backends (Sortant)
resource "oci_core_network_security_group_security_rule" "lb_egress_to_backends" {
  network_security_group_id = oci_core_network_security_group.lb_nsg.id
  direction                = "EGRESS"
  protocol                 = "6"  # TCP
  destination              = var.private_subnet_cidr  # CIDR des subnets privés
  destination_type         = "CIDR_BLOCK"
  
  tcp_options {
    destination_port_range {
      min = var.backend_port  # Port utilisé par vos backends (ex: 80)
      max = var.backend_port
    }
  }
}

### Règles pour les Backends Privés ###

# Règle 1 : Autoriser le trafic depuis le LB vers les backends
resource "oci_core_network_security_group_security_rule" "allow_lb_to_backend" {
  network_security_group_id = oci_core_network_security_group.private_nsg.id
  direction                = "INGRESS"
  protocol                 = "6"  # TCP
  source                   = var.public_subnet_cidr  # CIDR du subnet public du LB
  source_type              = "CIDR_BLOCK"
  
  tcp_options {
    destination_port_range {
      min = var.backend_port  # Port des backends (ex: 80)
      max = var.backend_port
    }
  }
}

# Règle 2 : Autoriser les réponses des backends vers le LB
resource "oci_core_network_security_group_security_rule" "allow_backend_egress" {
  network_security_group_id = oci_core_network_security_group.private_nsg.id
  direction                = "EGRESS"
  protocol                 = "6"  # TCP
  destination              = var.public_subnet_cidr  # CIDR du subnet public du LB
  destination_type         = "CIDR_BLOCK"
  
  tcp_options {
    destination_port_range {
      min = 32768  # Ports éphémères pour les réponses
      max = 60999
    }
  }
}


# Règle 3 : Autoriser l'accès VPN/on-premise (conservation de votre règle existante)
resource "oci_core_network_security_group_security_rule" "allow_vpn_ingress" {
  network_security_group_id = oci_core_network_security_group.private_nsg.id
  direction                = "INGRESS"
  protocol                 = "6"  # TCP
  source                   = var.ipsec_static_routes[0]  # CIDR de votre réseau on-premise
  source_type              = "CIDR_BLOCK"
  
  tcp_options {
    destination_port_range {
      min = 22  # SSH
      max = 22
    }
  }
}
