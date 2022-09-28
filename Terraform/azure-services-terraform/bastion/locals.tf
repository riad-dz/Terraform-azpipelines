locals {
  default_tags = {
    env   = var.environment
    stack = var.project
  }

  default_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-bas01-${var.subscription_prefix}")

  bastion_name = coalesce(var.custom_name, local.default_name)

  ip_configuration_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-ipc02-${var.subscription_prefix}")

  public_ip_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-ip01-${var.subscription_prefix}")
}