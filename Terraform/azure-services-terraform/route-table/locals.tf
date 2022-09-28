locals {
  name_prefix  = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  default_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-rt${format("%02d", var.rt_number)}-${var.subscription_prefix}")

  rt_name = coalesce(var.custom_name, local.default_name)

  default_tags = {
    env   = var.environment
    stack = var.project
  }
}
