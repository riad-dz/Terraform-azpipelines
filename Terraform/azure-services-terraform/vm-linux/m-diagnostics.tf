module "vm-logs" {
  source  = "../vm-logs"

  location    = var.location
  location_short    = var.location_short
  environment = var.environment
  environment_number = var.environment_number
  subscription_prefix = var.subscription_prefix
  environment_category = var.environment_category
  project       = var.project

  diagnostics_storage_account_name      = var.diagnostics_storage_account_name
  diagnostics_storage_account_sas_token = var.diagnostics_storage_account_sas_token

  vm_id = azurerm_linux_virtual_machine.vm.id

  tags = {
    environment = var.environment
    stack       = var.project
    vm_name     = azurerm_linux_virtual_machine.vm.name
  }
}