locals {
  name_prefix  = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  default_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-vnet${format("%02d", var.vnet_number)}-${var.subscription_prefix}")

  vnet_name = coalesce(var.custom_vnet_name, local.default_name)

  default_tags = {
    env   = var.environment
    stack = var.project
  }
}
