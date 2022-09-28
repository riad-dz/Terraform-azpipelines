locals {
  function_path = "./build/${var.name}.zip"
  storage_account_name = "${var.prefix}-${var.environment}"
}

data "azurerm_resource_group" "rg" {
  name = var.resource
}

data "azurerm_storage_account" "storage" {
  name = local.storage_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_storage_container" "container" {
  name = "functions"
  storage_account_name = data.azurerm_storage_account.storage.name
}

resource "azurerm_storage_blob" "code" {
    name = "${var.name}.zip"
    storage_account_name = data.azurerm_storage_account.storage.name
    storage_container_name = data.azurerm_storage_container.container.name
    type = "Block"
    source = local.function_path
}

data "azurerm_storage_account_sas" "sas" {
  connection_string = data.azurerm_storage_account.storage.primary_connection_string
  https_only = true
  start = "2019-01-01"
  expiry = "2021-12-31"
  resource_types {
    object = true
    container = false
    service = false
  }
  services {
    blob = true
    queue = false
    table = false
    file = false
  }
  permissions {
    read = true
    write = false
    delete = false
    list = false
    add = false
    create = false
    update = false
    process = false
  }
}

resource "azurerm_app_service_plan" "asp" {
  name = "${var.prefix}-plan"
  resource_group_name = data.azurerm_resource_group.rg.name
  location = var.location
  kind = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "function" {
  name = "${var.prefix}-${var.environment}"
  location = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  storage_account_name = data.azurerm_storage_account.storage.name
  storage_account_access_key = data.azurerm_storage_account.storage.primary_access_key
  version = "~2"

  app_settings = {
    https_only = true
    FUNCTIONS_WORKER_RUNTIME = "node"
    WEBSITE_NODE_DEFAULT_VERSION = "~12"
    FUNCTION_APP_EDIT_MODE = "readonly"
    HASH = base64encode(filesha256(local.function_path))
    WEBSITE_RUN_FROM_PACKAGE = "https://${data.azurerm_storage_account.storage.name}.blob.core.windows.net/${data.azurerm_storage_container.container.name}/${azurerm_storage_blob.code.name}${data.azurerm_storage_account_sas.sas.sas}"
  }
}
