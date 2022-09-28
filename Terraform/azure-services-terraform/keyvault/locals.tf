locals {
  default_tags = {
    env   = var.environment
    stack = var.project
  }

  # Generate prefix, truncate it to 21 characters and add "-kv" suffix
  default_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-kv${format("%02d", var.kv_number)}-${var.subscription_prefix}")
  name = coalesce(
    var.custom_name,
    substr(
      local.default_name,
      0,
      length(local.default_name) > 21 ? 20 : -1,
    ),
  )

  tenant_id = coalesce(
    var.tenant_id,
    data.azurerm_client_config.current_config.tenant_id,
  )
}
