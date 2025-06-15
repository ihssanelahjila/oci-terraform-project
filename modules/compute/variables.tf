
# ##############################################################################
# ########################## CONFIGURATION GÉNÉRALE ###########################
# ##############################################################################

variable "region" {
  description = "Nom de la région OCI (ex: eu-frankfurt-1)"
  type        = string
}

variable "compartment_id" {
  description = "Le Compartment OCID dans lequel déployer les ressources"
  type        = string
}

variable "availability_domain" {
  description = "Le domaine de disponibilité pour le déploiement"
  type        = string
}

# ##############################################################################
# ########################### CONFIGURATION DES VM #############################
# ##############################################################################

/*variable "num_instances" {
  description = "Nombre d'instances à déployer"
  type        = number
  default     = 1
}*/

/*
variable "instance_shape" {
  description = "Shape des instances "
  type        = string
  default     =  "VM.Standard.E4.Flex"
 
  
}

variable "instance_ocpus" {
  description = "Nombre de CPU par instance"
  type        = number
  default     = 1
}

variable "instance_shape_config_memory_in_gbs" {
  description = "Mémoire en Go par instance"
  type        = number
  default     = 16
}


/*variable "kms_management_endpoint" {
  description = "The management endpoint of the KMS vault"
  type        = string
}*/

/*
variable "private_subnet_2_id" {
  description = "ID du subnet privé pour les instances"
  type        = string
}

variable "private_nsg_id" {
  description = "ID du NSG privé pour les instances"
  type        = string
}

variable "ssh_public_key" {
  description = "Clé publique SSH pour accès aux instances"
  type        = string
}

/*variable "boot_volume_size_in_gbs" {
  description = "Taille du volume de démarrage en Go"
  type        = number
  default     = 47
}*/



variable "skip_source_dest_check" {
  description = "Ignorer la vérification source/destination"
  type        = bool
  default     = true
}

variable "instance_create_timeout" {
  description = "Timeout création instance (ex: 30m)"
  type        = string
  default     = "30m"
}

# ##############################################################################
# #################### CONFIGURATION LOAD BALANCER #############################
# ##############################################################################

variable "lb_shape" {
  description = "Shape du Load Balancer"
  type        = string
  default     = "100Mbps"
}

variable "lb_is_private" {
  description = "Si true, crée un LB privé"
  type        = bool
  default     = false
}

variable "lb_type" {
  description = "Type de LB (public/private)"
  type        = string
  default     = "public"
}

variable "public_subnet_1_id" {
  description = "ID du subnet public pour le LB"
  type        = string
}

variable "public_subnet_2_id" {
  description = "ID du subnet public pour le LB"
  type        = string
}
variable "lb_nsg_id" {
  description = "OCID du NSG pour le LB"
  type        = string
  default     = ""
}

variable "backend_ips" {
  description = "Liste des IPs des backends"
  type        = list(string)
}

# Configuration Listener
variable "listener_name" {
  description = "Nom du listener"
  type        = string
  default     = "http-listener"
}

variable "listener_protocol" {
  description = "Protocole du listener"
  type        = string
  default     = "HTTP"
}

variable "listener_port" {
  description = "Port du listener"
  type        = number
  default     = 80
}

# Configuration Backend
variable "backend_port" {
  description = "Port des backends"
  type        = number
  default     = 80
}

variable "backend_weight" {
  description = "Poids des backends"
  type        = number
  default     = 1
}

variable "backend_policy" {
  description = "Politique de backend"
  type        = string
  default     = "ROUND_ROBIN"
}

# Health Check
variable "health_check_protocol" {
  description = "Protocole health check"
  type        = string
  default     = "HTTP"
}

variable "health_check_port" {
  description = "Port health check"
  type        = number
  default     = 80
}

variable "health_check_url_path" {
  description = "URL path health check"
  type        = string
  default     = "/health"
}

variable "health_check_interval_ms" {
  description = "Intervalle health check (ms)"
  type        = number
  default     = 10000
}

variable "health_check_timeout_ms" {
  description = "Timeout health check (ms)"
  type        = number
  default     = 3000
}

variable "health_check_retries" {
  description = "Nombre de tentatives health check"
  type        = number
  default     = 3
}

# ##############################################################################
# ############################# TAGS ###########################################
# ##############################################################################

variable "defined_tags" {
  description = "Tags définis pour les ressources"
  type        = map(string)
  default     = {}
}

 variable "freeform_tags" {
  description = "Tags libres pour les ressources"
  type        = map(string)
  default     = {}
}

# ##############################################################################
# ######################## CONFIGURATION AVANCÉE ###############################
# ##############################################################################

variable "preemption_action_type" {
  description = "Action lors de préemption (TERMINATE/STOP)"
  type        = string
  default     = "TERMINATE"
  validation {
    condition     = contains(["TERMINATE", "STOP"], var.preemption_action_type)
    error_message = "Doit être 'TERMINATE' ou 'STOP'"
  }
}

variable "preserve_boot_volume" {
  description = "Conserver volume de démarrage après terminaison"
  type        = bool
  default     = false
}

variable "routing_policy_name" {
  description = "Nom de la politique de routage"
  type        = string
  default     = "default-routing-policy"
}




variable "public_security_list_id" {
  description = "ID de la security list publique"
  type        = string
}
