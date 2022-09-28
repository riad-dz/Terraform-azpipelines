locals {
  name_prefix  = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  default_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-rt${format("%02d", var.nsg_number)}-${var.subscription_prefix}")

  nsg_name = coalesce(var.custom_network_security_group_name, "${local.default_name}-nsg")

  default_tags = {
    env   = var.environment
    stack = var.project
  }
}