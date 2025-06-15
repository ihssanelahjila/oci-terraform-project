# ##############################################################################
# ############################### VCN (vcn.tf) #################################
# ##############################################################################

variable "compartment_id" {
  description = "L'ID du compartiment OCI"
  type        = string
}

variable "vcn_cidr" {
  description = "CIDR block du VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vcn_dns_label" {
  description = "DNS label du VCN"
  type        = string
  default     = "myvcn"
}

# ##############################################################################
# ########################### SUBNETS (subnets.tf) #############################
# ##############################################################################

variable "availability_domain" {
  description = "The availability domain for the resources"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR block pour le sous-réseau public 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block pour le sous-réseau public 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR block pour le sous-réseau privé 1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR block pour le sous-réseau privé 2"
  type        = string
  default     = "10.0.4.0/24"
}

variable "public_subnet_1_dns_label" {
  description = "Label DNS pour le subnet public 1"
  type        = string
  default     = "public1"
}

variable "public_subnet_2_dns_label" {
  description = "Label DNS pour le subnet public 2"
  type        = string
  default     = "public2"
}

variable "private_subnet_1_dns_label" {
  description = "Label DNS pour le subnet privé 1"
  type        = string
  default     = "private1"
}

variable "private_subnet_2_dns_label" {
  description = "Label DNS pour le subnet privé 2"
  type        = string
  default     = "private2"
}

# ##############################################################################
# ####################### SECURITY LISTS (security_lists.tf) ###################
# ##############################################################################

variable "public_ingress_rules" {
  description = "Règles ingress pour le subnet public"
  type = map(object({
    protocol = string
    source   = string
    port     = number
  }))
  default = {
    ssh = {
      protocol = "6" # TCP
      source   = "0.0.0.0/0"
      port     = 22
    },
    http = {
      protocol = "6"
      source   = "0.0.0.0/0"
      port     = 80
    },
    https = {
      protocol = "6"
      source   = "0.0.0.0/0"
      port     = 443
    }
  }
}

variable "public_egress_rules" {
  description = "Règles egress pour le subnet public"
  type = map(object({
    protocol    = string
    destination = string
  }))
  default = {
    all = {
      protocol    = "all"
      destination = "0.0.0.0/0"
    }
  }
}

variable "private_ingress_rules" {
  description = "Règles ingress pour le subnet privé"
  type = map(object({
    protocol = string
    source   = string
    port     = number
  }))
  default = {
    ssh = {
      protocol = "6" # TCP
      source   = "10.0.0.0/16"
      port     = 22
    }
  }
}

variable "private_egress_rules" {
  description = "Règles egress pour le subnet privé"
  type = map(object({
    protocol    = string
    destination = string
  }))
  default = {
    all = {
      protocol    = "all"
      destination = "0.0.0.0/0"
    }
  }
}

variable "security_list_ingress_security_rules_description" {
  description = "Description pour les règles ICMP"
  type        = string
  default     = "ICMP Rule for Path Discovery"
}

# ##############################################################################
# ############################### VPN (vpn.tf) ################################
# ##############################################################################

variable "client_public_ip" {
  description = "Adresse IP publique du routeur client (CPE)"
  type        = string
}

variable "ipsec_static_routes" {
  description = "Liste des réseaux CIDR à tunneliser via IPSEC"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "tunnel1_shared_secret" {
  description = "Secret partagé Tunnel 1"
  type        = string
  default     = "ihssane1"
  sensitive   = true
}

variable "tunnel2_shared_secret" {
  description = "Secret partagé Tunnel 2"
  type        = string
  default     = "ihssane2"
  sensitive   = true
}
variable "existing_drg_id" {
  description = "OCID du DRG existant à utiliser"
  type        = string
  default     = "ocid1.drg.oc1.eu-frankfurt-1.aaaaaaaa5re4gmgb54twvdjrwf5f4lp5waugj7dc6vzlavtkjorc7lwx6qtq"
}

# ##############################################################################
# ############################## NSG (nsg.tf) ##################################
# ##############################################################################


variable "lb_type" {
  description = "Type de Load Balancer"
  type        = string
  default     = "public"
}



variable "public_subnet_cidr" {
  description = "CIDR du subnet public principal"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block couvrant tous les subnets privés"
  type        = string
  default     = "10.0.0.0/16"
}

variable "backend_port" {
  description = "Le port utilisé par le backend pour recevoir le trafic"
  type        = number
  default     = 8080
}




variable "availability_domain_2" {
  description = "Deuxième AD "
  type        = string
  default     = ""
}