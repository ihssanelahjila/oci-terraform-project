resource "oci_load_balancer_load_balancer" "lb" {
  compartment_id = var.compartment_id
  display_name   = "${var.lb_type}-load-balancer-regional"
  shape          = var.lb_shape
  is_private     = false  # Load balancer public

  subnet_ids = [
    var.public_subnet_1_id,  # Subnet public en AD1
    var.public_subnet_2_id   # Subnet public en AD2
  ]

  network_security_group_ids = try([var.lb_nsg_id], null)

  # Pas de reserved_ips, pas de tags "local"
  
  freeform_tags = merge(var.freeform_tags, {
    type       = "public"
    deployment = "regional"
  })
}


# Listener (configuration inchangée mais fonctionnera avec LB local)
resource "oci_load_balancer_listener" "listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.lb.id # Référence corrigée
  name                     = var.listener_name
  default_backend_set_name = oci_load_balancer_backend_set.backend.name
  port                     = var.listener_port
  protocol                 = var.listener_protocol
}

# Backend Set 
resource "oci_load_balancer_backend_set" "backend" {
  load_balancer_id = oci_load_balancer_load_balancer.lb.id
  name             = "${var.lb_type}-backend-set" # Nom dynamique
  policy           = var.backend_policy

  health_checker {
    protocol            = var.health_check_protocol
    port                = var.health_check_port
    url_path            = var.health_check_url_path
    interval_ms         = var.health_check_interval_ms
    timeout_in_millis   = var.health_check_timeout_ms
    retries             = var.health_check_retries
  }
}

# Data Source pour récupérer automatiquement les IPs privées des VMs (inchangé)
data "oci_core_instances" "backend_vms" {
  compartment_id = var.compartment_id
  display_name   = "InstancePrefix*"  # Filtre pour toutes vos VMs (ajustez si nécessaire)
}

# Backends (liaison automatique )
resource "oci_load_balancer_backend" "backends" {
  for_each = { for vm in data.oci_core_instances.backend_vms.instances : vm.id => vm }

  load_balancer_id = oci_load_balancer_load_balancer.lb.id
  backendset_name  = oci_load_balancer_backend_set.backend.name
  ip_address       = each.value.private_ip  # Utilisation de l'IP privée
  port             = var.backend_port
  weight           = var.backend_weight
}

