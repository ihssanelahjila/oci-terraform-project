# Data source pour récupérer dynamiquement la clé KMS selon son nom et compartiment

data "oci_kms_keys" "kms_key" {
  management_endpoint = var.kms_management_endpoint
  compartment_id      = var.compartment_id
}

data "oci_core_images" "flex_image" {
  compartment_id           = var.compartment_id
  operating_system         = "Oracle Linux"
  operating_system_version = "9"
  shape                    = var.instance_shape  # Ajouté pour garantir la compatibilité
  
}

resource "oci_core_instance" "instance" {
  count                      = 1 # Nombre d'instances à créer, basé sur la variable num_instances
  availability_domain        = var.availability_domain # Domaine de disponibilité pour les instances
  compartment_id             = var.compartment_id # ID du compartiment OCI dans lequel les instances seront créées
  display_name               = "Instance${count.index}" # Nom d'affichage de l'instance, où count.index permet de générer un nom unique pour chaque instance
  shape                      = var.instance_shape # Forme de l'instance (type de machine), défini par la variable instance_shape

  shape_config { 
    ocpus         = var.instance_ocpus # Nombre de processeurs virtuels (OCPUs) pour l'instance
    memory_in_gbs = var.instance_shape_config_memory_in_gbs # Taille de la mémoire RAM en Go pour l'instance
  }  

  create_vnic_details {
    subnet_id              = var.private_subnet_2_id # ID du sous-réseau où l'instance sera connectée
    display_name           = "Vnic-${count.index}" # Nom du VNIC (Virtual Network Interface Card) pour l'instance
    assign_public_ip       = false # Ne pas assigner une adresse IP publique à l'instance (peut être changé à true si nécessaire)
    hostname_label         = "instance-${count.index}" # Label pour l'hôte (nom d'hôte de l'instance)
    nsg_ids                = [var.private_nsg_id] # ID du Network Security Group (NSG) pour l'instance
    skip_source_dest_check = var.skip_source_dest_check # Option pour désactiver les vérifications de source/destination pour le VNIC
  }

  source_details {
    source_type             = "image" # Type de source pour l'instance (ici, une image)
     source_id   = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa3ttfvqe6mqdoqigc3kud4sxa6hwq5l6pcbdlo7jx2d6urzbw7psq"
   #source_id               = data.oci_core_images.flex_image.images[0].id # OCID de l'image utilisée pour créer l'instance, récupérée dynamiquement
    #boot_volume_size_in_gbs = var.boot_volume_size_in_gbs # Taille du volume de démarrage (en Go)
    #kms_key_id              = length(data.oci_kms_keys.kms_key.keys) > 0 ? data.oci_kms_keys.kms_key.keys[0].id : null # OCID de la clé KMS récupérée dynamiquement ou null si absente
  }

  # Configuration pour les instances préemptibles
  preemptible_instance_config {
    preemption_action {
      type                 = var.preemption_action_type # Action à effectuer lors de la préemption (TERMINATE ou STOP)
      preserve_boot_volume = var.preserve_boot_volume # Détermine si le volume de démarrage doit être conservé après terminaison
    }
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = base64encode(file("${path.module}/userdata/bootstrap"))
  }
  
 

  timeouts {
    create = var.instance_create_timeout # Temps maximum autorisé pour la création de l'instance, défini par la variable instance_create_timeout
  }
}
