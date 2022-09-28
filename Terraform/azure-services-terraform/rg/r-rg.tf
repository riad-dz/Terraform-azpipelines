resource "azurerm_resource_group" "main_rg" {
  name     = local.rg_name
  location = var.location

  tags = merge(local.default_tags, var.extra_tags)

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_management_lock" "resource-group-level-lock" {
  name       = "${local.rg_name}-level-lock"
  scope      = azurerm_resource_group.main_rg.id
  lock_level = var.lock_level
  notes      = "Resource Group '${local.rg_name}' is locked with '${var.lock_level}' level."

  count = var.lock_level == "" ? 0 : 1
}
