module "keyvault" {
  source  = "../keyvault"

  environment         = var.environment
  location            = var.location
  location_short      = var.location_short
  resource_group_name = coalesce(var.keyvault_resource_group_name, var.resource_group_name)
  tenant_id           = var.tenant_id
  environment_number = var.environment_number
  kv_number = 1
  subscription_prefix = var.subscription_prefix
  environment_category = var.environment_category
  project       = var.project

  custom_name = var.keyvault_custom_name
  sku_name    = var.keyvault_sku
  extra_tags  = merge(var.extra_tags, var.keyvault_extra_tags)

  admin_objects_ids  = var.keyvault_admin_objects_ids
  reader_objects_ids = var.keyvault_reader_objects_ids

  enabled_for_deployment          = var.keyvault_enabled_for_deployment
  enabled_for_disk_encryption     = var.keyvault_enabled_for_disk_encryption
  enabled_for_template_deployment = var.keyvault_enabled_for_template_deployment

  enable_logs_to_log_analytics    = true
  logs_log_analytics_workspace_id = module.logs.log_analytics_workspace_id

  enable_logs_to_storage  = true
  logs_storage_account_id = module.logs.logs_storage_account_id
  logs_storage_retention  = var.log_analytics_workspace_retention_in_days

  purge_protection_enabled = true

  network_acls = var.keyvault_network_acls

}