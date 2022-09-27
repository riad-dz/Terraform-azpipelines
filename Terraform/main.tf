resource "azurerm_resource_group" "main_rg" {
 name=var.rg_name
 location=var.location_rg

tags = {
app_name= upper(var.application_name)
env= upper(var.environment)
owner= var.owner
}

}

#resource "azurerm_management_lock" "resource-group-level-lock" {
#  name       = "${var.rg_name}-level-lock"
#  scope      = azurerm_resource_group.main_rg.id
#  lock_level = var.lock_level
#  notes      = "Resource Group '${var.rg_name}' is locked with '${var.lock_level}' level."
#
#  count = var.lock_level == "" ? 0 : 1
#}
