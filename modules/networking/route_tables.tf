resource "oci_core_route_table" "public_rt" {
  compartment_id = var.compartment_id # Compartiment OCI
  vcn_id         =  oci_core_virtual_network.vcn.id
  display_name   = "public_rt"        # Nom de la table de routage

  route_rules {
    destination       = "0.0.0.0/0"                                   # Destination : tout le trafic Internet
    network_entity_id = oci_core_internet_gateway.internet_gateway.id # Passerelle = Internet Gateway  
    # Si du trafic correspond à la destination (Internet), envoie-le vers cette passerelle Internet.
  }
 route_rules {
  destination       = var.ipsec_static_routes[0]  # CIDR on-premise
  destination_type  = "CIDR_BLOCK"
  
  network_entity_id = var.existing_drg_id #network_entity_id = oci_core_drg.nplusone_drg.id  # Utiliser ca si vous avez crere une nouvelle DRG
}
}

resource "oci_core_route_table" "private_rt" {
  compartment_id = var.compartment_id
  vcn_id         =  oci_core_virtual_network.vcn.id
  display_name   = "private_route_table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
}

#vpnn **************** Ajout des routes dans la VCN pour diriger le trafic vers le DRG
resource "oci_core_route_table" "vpn_route_table" {
  compartment_id = var.compartment_id
  vcn_id         =  oci_core_virtual_network.vcn.id
  display_name   = "vpn-route-table"

  route_rules {
    destination       = var.ipsec_static_routes[0]  
    destination_type  = "CIDR_BLOCK"
    network_entity_id = var.existing_drg_id   #network_entity_id = oci_core_drg.nplusone_drg.id  # Utiliser ca si vous avez crere une nouvelle DRG
  }
}
