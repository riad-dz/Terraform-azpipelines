locals {
  default_tags = {
    env   = var.environment
    stack = var.project
  }
  default_vm_tags = {
    os_family       = "linux"
    os_distribution = lookup(var.vm_image, "offer", "undefined")
    os_version      = lookup(var.vm_image, "sku", "undefined")
  }

  name_prefix  = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  default_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-vm${format("%02d", var.vm_number)}-${var.subscription_prefix}")

  vm_name = coalesce(var.custom_name, local.default_name)

  nic_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-nic01-${var.subscription_prefix}")

  ip_configuration_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-ipc01-${var.subscription_prefix}")
}