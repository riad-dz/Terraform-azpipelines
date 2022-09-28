locals {
    backend_address_pool_name      = "${azurerm_virtual_network.aks.name}-beap"
    frontend_port_name             = "${azurerm_virtual_network.aks.name}-feport"
    frontend_ip_configuration_name = "${azurerm_virtual_network.aks.name}-feip"
    http_setting_name              = "${azurerm_virtual_network.aks.name}-be-htst"
    listener_name                  = "${azurerm_virtual_network.aks.name}-httplstn"
    request_routing_rule_name      = "${azurerm_virtual_network.aks.name}-rqrt"
    app_gateway_subnet_name = "agwsubnet"
}

data "azurerm_resource_group" "rg" {
  name = var.resource
}

resource "azurerm_container_registry" "main" {
  name                    = "${var.prefix}${title(var.environment)}"
  resource_group_name     = var.resource
  location                = var.location
  sku                     = var.sku
  admin_enabled           = true

  tags = {
    Creation_Date         = var.date
  }
  lifecycle {
    ignore_changes        = [
      tags,
    ]
  }
}

# User Assigned Identities 
resource "azurerm_user_assigned_identity" "aks" {
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  name = "identityTesting"

  tags = {
    Creation_Date = var.date
  }

  lifecycle {
    ignore_changes        = [
      tags,
    ]
  }
}

resource "azurerm_virtual_network" "aks" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = [var.virtual_network_address_prefix]

  tags = {
    Creation_Date = var.date
  }

  lifecycle {
    ignore_changes        = [
      tags,
    ]
  }
}

resource "azurerm_subnet" "kube" {
  name                 = var.aks_subnet_name
  address_prefixes = [ var.aks_subnet_address_prefix ]
  virtual_network_name = azurerm_virtual_network.aks.name
  resource_group_name  = data.azurerm_resource_group.rg.name

  depends_on = [azurerm_virtual_network.aks]
}

resource "azurerm_subnet" "appgw" {
  name                 = local.app_gateway_subnet_name
  address_prefixes = [ var.app_gateway_subnet_address_prefix ]
  virtual_network_name = azurerm_virtual_network.aks.name
  resource_group_name  = data.azurerm_resource_group.rg.name

  depends_on = [azurerm_virtual_network.aks]
}

# Public Ip 
resource "azurerm_public_ip" "aks" {
  name                         = "spotlightDev"
  location                     = var.location
  resource_group_name          = data.azurerm_resource_group.rg.name
  allocation_method            = "Static"
  sku                          = "Standard"
  domain_name_label            = "spotlightdev"

  tags = {
    Creation_Date = var.date
  }

  lifecycle {
    ignore_changes        = [
      tags,
    ]
  }
}

resource "azuread_application" "aks" {
  name                       = "k8sSpotlightDev"
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = false
}

resource "azuread_service_principal" "aks" {
  application_id = azuread_application.aks.application_id

  depends_on = [
    azuread_application.aks
  ]
}

resource "azuread_service_principal_password" "aks" {
  service_principal_id = azuread_service_principal.aks.id
  value                = random_password.aks.result
  end_date             = "2099-01-01T01:02:03Z"

  depends_on = [
    azuread_service_principal.aks
  ]
}

resource "random_password" "aks" {
  length = 32
  special = true
}

resource "azurerm_application_gateway" "aks" {
  name                = var.app_gateway_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  sku {
    name     = var.app_gateway_sku
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.appgw.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.aks.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  tags = {
    Creation_Date = var.date
  }

  lifecycle {
    ignore_changes        = [
      tags,
      url_path_map,
      backend_address_pool,
      backend_http_settings,
      frontend_port,
      http_listener,
      probe,
      request_routing_rule,
    ]
  }

  depends_on = [azurerm_virtual_network.aks, azurerm_public_ip.aks]
}

resource "azurerm_role_assignment" "network" {
  scope                = azurerm_subnet.kube.id
  role_definition_name = "Network Contributor"
  principal_id         = azuread_service_principal.aks.object_id

  depends_on = [ azurerm_subnet.kube, azuread_service_principal.aks]
}

resource "azurerm_role_assignment" "identity" {
  scope                = azurerm_user_assigned_identity.aks.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azuread_service_principal.aks.object_id
  depends_on           = [azurerm_user_assigned_identity.aks, azuread_service_principal.aks]
}

resource "azurerm_role_assignment" "gw" {
  scope                = azurerm_application_gateway.aks.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
  depends_on           = [azurerm_user_assigned_identity.aks, azurerm_application_gateway.aks, azuread_service_principal.aks]
}

resource "azurerm_role_assignment" "rg" {
  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
  depends_on           = [azurerm_user_assigned_identity.aks, azurerm_application_gateway.aks, azuread_service_principal.aks]
}

resource "azurerm_role_assignment" "acr" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = azuread_service_principal.aks.object_id

  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name       = var.aks_name
  location   = var.location
  dns_prefix = var.aks_dns_prefix

  resource_group_name = data.azurerm_resource_group.rg.name

  kubernetes_version = "1.17.7"

  linux_profile {
    admin_username = var.vm_user_name

    ssh_key {
      key_data = file(var.public_ssh_key_path)
    }
  }

  addon_profile {
    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = true
    }
  }

  default_node_pool {
    name                    = "agentpool"
    node_count              = var.aks_agent_count
    vm_size                 = var.aks_agent_vm_size
    os_disk_size_gb         = var.aks_agent_os_disk_size
    vnet_subnet_id          = azurerm_subnet.kube.id
    orchestrator_version      = "1.17.7"
  }

  service_principal {
    client_id     = azuread_service_principal.aks.application_id
    client_secret = azuread_service_principal_password.aks.value
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = var.aks_dns_service_ip
    docker_bridge_cidr = var.aks_docker_bridge_cidr
    service_cidr       = var.aks_service_cidr
  }

  depends_on = [azurerm_virtual_network.aks, azurerm_application_gateway.aks, azuread_service_principal.aks]

  tags = {
    Creation_Date = var.date
  }

  lifecycle {
    ignore_changes        = [
      tags,
    ]
  }
}

resource "local_file" "k8s" {
    content     = azurerm_kubernetes_cluster.k8s.kube_config_raw
    filename    = "/tmp/k8s"
}

resource "local_file" "az" {
    content     = jsonencode({
      "subscription_id": regex("/subscriptions/(.*)/resourceGroups", data.azurerm_resource_group.rg.id).0,
      "resource_group": data.azurerm_resource_group.rg.name,
      "appgw_name": azurerm_application_gateway.aks.name,
      "identity_resource_id": azurerm_user_assigned_identity.aks.id,
      "identity_client_id": azurerm_user_assigned_identity.aks.client_id
    })
    filename    = "/tmp/az"
}