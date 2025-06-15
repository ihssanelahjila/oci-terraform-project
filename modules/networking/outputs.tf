# ##############################################################################
# ############################### VCN OUTPUTS ##################################
# ##############################################################################

output "vcn_id" {
  description = "L'ID du VCN créé"
  value       = oci_core_virtual_network.vcn.id
}

# ##############################################################################
# ############################## SUBNET OUTPUTS ################################
# ##############################################################################

output "public_subnet_1_id" {
  description = "ID du subnet public 1"
  value       = oci_core_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  description = "ID du subnet public 2"
  value       = oci_core_subnet.public_subnet_2.id
}

output "private_subnet_1_id" {
  description = "ID du subnet privé 1"
  value       = oci_core_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  description = "ID du subnet privé 2"
  value       = oci_core_subnet.private_subnet_2.id
}

# ##############################################################################
# ############################### NSG OUTPUTS ##################################
# ##############################################################################

output "public_nsg_id" {
  description = "ID du NSG public"
  value       = oci_core_network_security_group.public_nsg.id
}

output "private_nsg_id" {
  description = "ID du NSG privé"
  value       = oci_core_network_security_group.private_nsg.id
}

output "lb_nsg_id" {
  description = "ID du NSG pour le Load Balancer"
  value       = oci_core_network_security_group.lb_nsg.id
}

output "public_security_list_id" {
  description = "ID de la security list publique"
  value       = oci_core_security_list.public_security_list.id
}

# ##############################################################################
# ############################### VPN OUTPUTS ##################################
# ##############################################################################



output "ipsec_connection_details" {
  description = "Détails complets de la connexion IPSEC"
  value       = oci_core_ipsec.nplusone_ipsec_connection
  sensitive   = true
}

# Configuration des tunnels
output "tunnel1_configuration" {
  description = "Configuration complète du tunnel 1"
  value       = oci_core_ipsec_connection_tunnel_management.tunnel1_management
  sensitive   = true
}

output "tunnel2_configuration" {
  description = "Configuration complète du tunnel 2"
  value       = oci_core_ipsec_connection_tunnel_management.tunnel2_management
  sensitive   = true
}

# Informations pratiques VPN
output "tunnel_public_ips" {
  description = "IPs publiques des tunnels VPN"
  value = {
    tunnel1 = data.oci_core_ipsec_connection_tunnels.ipsec_tunnels.ip_sec_connection_tunnels[0].vpn_ip
    tunnel2 = data.oci_core_ipsec_connection_tunnels.ipsec_tunnels.ip_sec_connection_tunnels[1].vpn_ip
  }
}

output "tunnel_status" {
  description = "Statut des tunnels VPN"
  value = {
    tunnel1 = data.oci_core_ipsec_connection_tunnels.ipsec_tunnels.ip_sec_connection_tunnels[0].status
    tunnel2 = data.oci_core_ipsec_connection_tunnels.ipsec_tunnels.ip_sec_connection_tunnels[1].status
  }
}

output "required_router_config" {
  description = "Configuration requise pour le routeur client"
  value = {
    cpe_ip          = oci_core_cpe.client_cpe.ip_address
    #drg_id          = oci_core_drg.nplusone_drg.id
    drg_id   = var.existing_drg_id 
    static_routes   = var.ipsec_static_routes
    ike_version     = "V2"
    encryption      = "AES-256-CBC"
    hashing         = "SHA2-256"
    dh_group        = "GROUP19"
  }
}
