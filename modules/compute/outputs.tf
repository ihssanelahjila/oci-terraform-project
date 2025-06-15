# ##############################################################################
# ########################### INSTANCE OUTPUTS #################################
# ##############################################################################

output "instance_ids" {
  description = "IDs des instances créées"
  value       = oci_core_instance.instance[*].id
}

output "instance_public_ips" {
  description = "Adresses IP publiques des instances (si configurées)"
  value       = oci_core_instance.instance[*].public_ip
}

output "instance_private_ips" {
  description = "Adresses IP privées des instances"
  value       = oci_core_instance.instance[*].private_ip
}



output "vm_private_ips" {
  description = "Alias pour les IPs privées des VMs"
  value       = oci_core_instance.instance[*].private_ip
}

output "instance_display_names" {
  description = "Noms d'affichage des instances"
  value       = oci_core_instance.instance[*].display_name
}

data "oci_core_vnic_attachments" "instance_vnics" {
  for_each       = { for idx, inst in oci_core_instance.instance : idx => inst }
  compartment_id = var.compartment_id
  instance_id    = each.value.id
}

data "oci_core_vnic" "primary_vnic" {
  for_each = data.oci_core_vnic_attachments.instance_vnics
  vnic_id  = each.value.vnic_attachments[0].vnic_id
}

output "instance_private_ips_vnic" {
  description = "Adresses IP privées récupérées depuis les VNICs"
  value       = {
    for idx, vnic in data.oci_core_vnic.primary_vnic :
    idx => vnic.private_ip_address
  }
}


output "instance_lifecycle_states" {
  description = "Lifecycle states of the instances"
  value       = [for instance in oci_core_instance.instance : instance.state]
}

# ##############################################################################
# ###################### LOAD BALANCER OUTPUTS #################################
# ##############################################################################

output "load_balancer_ip" {
  description = "Adresse IP du Load Balancer"
  value       = oci_load_balancer_load_balancer.lb.ip_address_details[0].ip_address
}


output "image_count" {
  value = length(data.oci_core_images.flex_image.images)
}

