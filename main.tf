# ************************************************** Networking Module **************************************************
module "networking" {
  source = "./modules/networking"
  compartment_id = var.compartment_id
  availability_domain = var.availability_domain 

}

# ************************************************** Compute Module **************************************************
module "compute" {
  source = "./modules/compute"
  region = var.region 

  # Configuration Instance
  availability_domain          = var.availability_domain
  compartment_id          = var.compartment_id
  private_nsg_id               = module.networking.private_nsg_id
  private_subnet_2_id                = module.networking.private_subnet_2_id
  public_subnet_2_id        = module.networking.public_subnet_2_id # Utilise l'output du module
  public_subnet_1_id        = module.networking.public_subnet_1_id # Utilise l'output du module

  ssh_public_key               = var.ssh_public_key
      
  public_security_list_id      = module.networking.public_security_list_id # Doit être output par le module networking

  # Load Balancer Configuration
   
  lb_nsg_id    = module.networking.lb_nsg_id
   
  kms_management_endpoint = module.vault.kms_management_endpoint


} 

module "iam" {
  source = "./modules/iam"
 
  compartment_id      = var.compartment_id

  tenancy_ocid      = var.tenancy_ocid    

}


 module "vault" {
  source             = "./modules/vault"
  compartment_id      = var.compartment_id
    
} 
