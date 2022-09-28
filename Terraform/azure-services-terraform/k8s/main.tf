provider "helm" {
  version = "1.2.2"
  kubernetes {
    host = azurerm_kubernetes_cluster.main.kube_config[0].host

    client_key             = base64decode(azurerm_kubernetes_cluster.main.kube_config[0].client_key)
    client_certificate     = base64decode(azurerm_kubernetes_cluster.main.kube_config[0].client_certificate)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate)
    load_config_file       = false
  }
}

resource "azurerm_kubernetes_cluster" "main" {
  name                    = "${var.prefix}${title(var.environment)}"
  location                = var.location
  resource_group_name     = var.resource
  dns_prefix              = var.prefix

  default_node_pool {
    name                  = "default"
    node_count            = 1
    vm_size               = "Standard_A2_v2"
    enable_auto_scaling   = false
    enable_node_public_ip = false
    max_pods              = 99
    type                  = "VirtualMachineScaleSets"
    vnet_subnet_id        = var.subnet_id
  }

  identity {
    type                  = "SystemAssigned"
  }

  tags = {
    Environment           = var.environment
    Creation_Date         = var.date
  }

  addon_profile {
    aci_connector_linux {
      enabled             = false
    }

    azure_policy {
      enabled             = false
    }

    http_application_routing {
      enabled             = false
    }

    kube_dashboard {
      enabled             = true
    }

    oms_agent {
      enabled             = false
    }
  }

  lifecycle {
    ignore_changes        = [
      tags,
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1
  vnet_subnet_id        = var.subnet_id

  tags = {
    Environment           = var.environment
    Creation_Date         = var.date
  }

  lifecycle {
    ignore_changes        = [
      tags,
    ]
  }
}