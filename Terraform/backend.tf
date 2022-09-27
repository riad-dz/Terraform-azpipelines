terraform {
  backend "azurerm" {
    resource_group_name      = "#{rg_backend_name}#"
    storage_account_name     = "#{storage_account_backend}#"
    container_name           = "#{container_tfstate}#"
    key                      = "#{key_tfstate}#"
  }
}