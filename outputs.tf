# Outputs Networking
output "vcn_id" {
  description = "ID du VCN créé"
  value       = module.networking.vcn_id
}

output "public_subnet_ids" {
  description = "IDs des subnets publics"
  value       = [module.networking.public_subnet_2_id, module.networking.public_subnet_2_id]
}


output "nsg_ids" {
  description = "IDs des NSGs créés"
  value       = {
    public_nsg_id  = module.networking.public_nsg_id
    private_nsg_id = module.networking.private_nsg_id
    lb_nsg_id      = module.networking.lb_nsg_id
  }
}

output "vault_id" {
  value = module.vault.vault_id
}

output "private_subnet_ids" {
  value = [
    module.networking.private_subnet_1_id,
    module.networking.private_subnet_2_id
  ]
}

# Outputs Compute

output "instance_private_ips" {
  description = "IPs privées des instances"
  value       = module.compute.instance_private_ips
}

output "instance_public_ips" {
  description = "IPs publiques des instances (si existantes)"
  value       = module.compute.instance_public_ips
}

# Output Load Balancer
 output "load_balancer_ip" {
  value = module.compute.load_balancer_ip
} 
