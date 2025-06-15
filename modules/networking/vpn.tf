# 1. Création du Dynamic Routing Gateway (DRG) - requis pour le VPN IPSEC
/*resource "oci_core_drg" "nplusone_drg" {
  compartment_id = var.compartment_id  # Compartiment OCI où créer le DRG
  display_name   = "nplusone-drg"      # Nom d'affichage du DRG
}*/
 


# 2. Attachement du DRG à la VCN (NÉCESSAIRE pour que le VPN fonctionne)
resource "oci_core_drg_attachment" "vpn_drg_attachment" {
  #drg_id       = oci_core_drg.nplusone_drg.id  # ID du DRG créé
  drg_id = var.existing_drg_id 
  vcn_id       = oci_core_virtual_network.vcn.id                  # ID de votre VCN
  display_name = "vpn-drg-attachment"          # Nom explicite
}

# 3. Data source pour récupérer les modèles de CPE disponibles
data "oci_core_cpe_device_shapes" "available_shapes" {
  filter {
    name   = "name"     # Filtrage sur le nom (ici, tous les modèles)
    values = ["*"]
  }
}



# 4. Configuration du CPE (équipement client)
resource "oci_core_cpe" "client_cpe" {
  compartment_id      = var.compartment_id     # Compartiment OCI
  ip_address          = var.client_public_ip   # IP publique du routeur client
  display_name        = "client-cpe-device"    # Nom d'affichage du CPE
  cpe_device_shape_id = data.oci_core_cpe_device_shapes.available_shapes.cpe_device_shapes[0].cpe_device_shape_id  # Modèle de CPE
}

# 5. Création de la connexion VPN IPSEC
resource "oci_core_ipsec" "nplusone_ipsec_connection" {
  compartment_id = var.compartment_id            # Compartiment OCI
  cpe_id         = oci_core_cpe.client_cpe.id    # ID du CPE
  #drg_id         = oci_core_drg.nplusone_drg.id  # ID du DRG
   drg_id = var.existing_drg_id
  static_routes  = var.ipsec_static_routes       # Routes à tunneliser (ex: ["10.0.0.0/16"])
  display_name   = "nplusone-to-client-ipsec"    # Nom de la connexion IPSEC
}

# 6. Data source pour récupérer les tunnels IPSEC (doit être APRÈS la création de la connexion)
data "oci_core_ipsec_connection_tunnels" "ipsec_tunnels" {
  ipsec_id = oci_core_ipsec.nplusone_ipsec_connection.id  # ID de la connexion IPSEC
}

# 7. Configuration du tunnel 1 (avec gestion dynamique via data source)
resource "oci_core_ipsec_connection_tunnel_management" "tunnel1_management" {
  ipsec_id      = oci_core_ipsec.nplusone_ipsec_connection.id
  tunnel_id     = data.oci_core_ipsec_connection_tunnels.ipsec_tunnels.ip_sec_connection_tunnels[0].id  # Récupère le 1er tunnel
  routing       = "STATIC"    # Type de routage (STATIC ou BGP)
  ike_version   = "V2"        # Version IKE (V1 ou V2)
  display_name  = "tunnel1"   # Nom du tunnel
  shared_secret = var.tunnel1_shared_secret  # Clé pré-partagée (à sécuriser dans OCI Vault)
}

# 8. Configuration du tunnel 2 (pour haute disponibilité)
resource "oci_core_ipsec_connection_tunnel_management" "tunnel2_management" {
  ipsec_id      = oci_core_ipsec.nplusone_ipsec_connection.id
  tunnel_id     = data.oci_core_ipsec_connection_tunnels.ipsec_tunnels.ip_sec_connection_tunnels[1].id  # Récupère le 2ème tunnel
  routing       = "STATIC"
  ike_version   = "V2"
  display_name  = "tunnel2"
  shared_secret = var.tunnel2_shared_secret
}

