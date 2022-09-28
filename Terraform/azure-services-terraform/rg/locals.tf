locals {
  default_tags = {
    env   = var.environment
    stack = var.project
    Infra_As_Code = "terraform"
    Application_Name = upper(var.project)
    Application_Code = upper(substr(var.project, 0, 3))
    Environment = var.environment_category
    Owner = local.owners
    Supported_By = local.owners
    Created_By = element(var.owners, 0)
  }

  name_prefix  = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  default_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-rg${format("%02d", var.rg_number)}-${var.subscription_prefix}")

  rg_name = coalesce(var.custom_rg_name, local.default_name)
  owners = join(",", var.owners)
}
