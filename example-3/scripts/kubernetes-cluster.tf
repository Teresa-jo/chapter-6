# Creates a managed Kubernetes cluster on Azure.

resource "azurerm_kubernetes_cluster" "cluster" {
    name                = "myproject-myapp-aks"
    location            = var.location
    resource_group_name = azurerm_resource_group.flixtube.name
    dns_prefix          = "myproject-myapp-aks"  # Use the same name for dns_prefix

    kubernetes_version  = "1.27.3"  # Update this line

    linux_profile {
        admin_username = var.admin_username

        ssh_key {
            key_data = "${trimspace(tls_private_key.key.public_key_openssh)} ${var.admin_username}@azure.com"
        }
    }

    default_node_pool {
        name            = "default"
        node_count      = 1
        vm_size         = "Standard_B2ms"
    }

    service_principal {
        client_id     = var.client_id
        client_secret = var.client_secret
    }
}

output "cluster_client_key" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config[0].client_key
  sensitive = true
}

output "cluster_client_certificate" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config[0].client_certificate
  sensitive = true
}

output "cluster_cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "cluster_cluster_username" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config[0].username
  sensitive = true
}

output "cluster_cluster_password" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config[0].password
  sensitive = true
}

output "cluster_host" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config[0].host
  sensitive = true
}

